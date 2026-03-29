import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upsc_wars_new/core/constants/mcq_seed_constants.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/core/logger/app_logger.dart';
import 'package:upsc_wars_new/features/mcq_seed/data/parsing/mcq_bundle_json_parser.dart';
import 'package:upsc_wars_new/features/mcq_seed/domain/entities/mcq_seed_progress.dart';
import 'package:upsc_wars_new/features/mcq_seed/domain/repositories/mcq_seed_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Loads `assets/questions/en/<subject>/<n>.json` and inserts rows into SQLite.
class McqSeedRepositoryImpl implements McqSeedRepository {
  /// Creates the repository with an open database and preferences.
  McqSeedRepositoryImpl({
    required Database database,
    required SharedPreferences preferences,
  })  : _db = database,
        _preferences = preferences;

  final Database _db;
  final SharedPreferences _preferences;

  @override
  bool isSeedMarkedComplete() {
    return _preferences.getBool(McqSeedConstants.prefsSeedCompleteKey) ?? false;
  }

  @override
  Future<void> markSeedComplete() async {
    await _preferences.setBool(McqSeedConstants.prefsSeedCompleteKey, true);
  }

  @override
  Future<Either<Failure, Unit>> seedFromAssetsIfNeeded({
    required void Function(McqSeedProgress progress) onProgress,
  }) async {
    final totalSlots =
        McqSeedConstants.subjectFolders.length * McqSeedConstants.filesPerSubject;
    var completedSlots = 0;

    try {
      for (final folder in McqSeedConstants.subjectFolders) {
        final label = _folderToDisplayLabel(folder);
        for (var n = 1; n <= McqSeedConstants.filesPerSubject; n++) {
          final path =
              '${McqSeedConstants.assetRootEn}/$folder/$n.json';
          try {
            final raw = await rootBundle.loadString(path);
            final parsed = await compute(parseMcqBundleJson, raw);
            final mcqList = (parsed['mcq'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
            final contentList = (parsed['content'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
            final tableList = (parsed['table'] as List<dynamic>)
                .cast<Map<String, dynamic>>();

            await _db.transaction((txn) async {
              final batch = txn.batch();
              for (final row in mcqList) {
                batch.insert(
                  'mcq',
                  row,
                  conflictAlgorithm: ConflictAlgorithm.replace,
                );
              }
              for (final row in contentList) {
                batch.insert(
                  'mcq_content_en',
                  row,
                  conflictAlgorithm: ConflictAlgorithm.replace,
                );
              }
              for (final row in tableList) {
                batch.insert(
                  'mcqs_with_table_en',
                  row,
                  conflictAlgorithm: ConflictAlgorithm.replace,
                );
              }
              await batch.commit(noResult: true);
            });
          } on FlutterError catch (e) {
            AppLogger.warning(
              'MCQ asset missing or invalid: $path',
              error: e,
            );
          } catch (e, st) {
            AppLogger.error(
              'MCQ import error',
              error: e,
              stackTrace: st,
            );
            return Left(
              AssetFailure(
                'Failed to import $path: $e',
              ),
            );
          }

          completedSlots++;
          onProgress(
            McqSeedProgress(
              overallFraction: completedSlots / totalSlots,
              subjectFraction: n / McqSeedConstants.filesPerSubject,
              currentSubjectFolder: folder,
              currentSubjectLabel: label,
            ),
          );
        }
      }
      return const Right(unit);
    } catch (e, st) {
      AppLogger.error(
        'MCQ seeding failed',
        error: e,
        stackTrace: st,
      );
      return Left(CacheFailure(e.toString()));
    }
  }

  static String _folderToDisplayLabel(String folder) {
    if (folder.isEmpty) return folder;
    return folder
        .split('_')
        .map((part) {
          if (part.isEmpty) return part;
          return part[0].toUpperCase() + part.substring(1);
        })
        .join(' ');
  }
}
