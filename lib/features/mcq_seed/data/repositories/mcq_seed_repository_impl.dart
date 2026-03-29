import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show AssetManifest, rootBundle;
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upsc_wars_new/core/constants/mcq_seed_constants.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/core/logger/app_logger.dart';
import 'package:upsc_wars_new/features/mcq_seed/data/parsing/mcq_bundle_json_parser.dart'
    show parseMcqBundleJsonBatch;
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
    try {
      final pathsByFolder = <String, List<String>>{};
      final manifest =
          McqSeedConstants.fileCountMode == McqSeedFileCountMode.allBundledJson
              ? await AssetManifest.loadFromAssetBundle(rootBundle)
              : null;
      for (final folder in McqSeedConstants.subjectFolders) {
        pathsByFolder[folder] =
            await _jsonAssetPathsForSubjectFolder(folder, manifest);
      }

      final totalSlots = pathsByFolder.values.fold<int>(
        0,
        (sum, paths) => sum + paths.length,
      );

      if (totalSlots == 0) {
        AppLogger.warning(
          'MCQ seed: no JSON asset paths resolved — check ${McqSeedConstants.fileCountMode} '
          'and pubspec assets',
        );
        return const Right(unit);
      }

      var completedSlots = 0;
      final batchSize = McqSeedConstants.seedBundleBatchSize.clamp(1, 32);

      try {
        await _enableSqliteBulkImportMode(_db);
        for (final folder in McqSeedConstants.subjectFolders) {
          final label = _folderToDisplayLabel(folder);
          final paths = pathsByFolder[folder] ?? <String>[];
          final subjectFileCount = paths.length;
          if (subjectFileCount == 0) {
            AppLogger.warning(
              'MCQ seed: no JSON files for subject folder $folder',
            );
            continue;
          }

          for (var start = 0; start < paths.length; start += batchSize) {
            final end = start + batchSize > paths.length
                ? paths.length
                : start + batchSize;
            final chunk = paths.sublist(start, end);

            final rawResults = await Future.wait(
              chunk.map((path) async {
                try {
                  return await rootBundle.loadString(path);
                } on FlutterError catch (e) {
                  AppLogger.warning(
                    'MCQ asset missing or invalid: $path',
                    error: e,
                  );
                  return null;
                }
              }),
            );

            final raws = rawResults.whereType<String>().toList();
            if (raws.isEmpty) {
              completedSlots += chunk.length;
              onProgress(
                McqSeedProgress(
                  overallFraction: completedSlots / totalSlots,
                  subjectFraction: end / subjectFileCount,
                  currentSubjectFolder: folder,
                  currentSubjectLabel: label,
                ),
              );
              continue;
            }

            late final Map<String, dynamic> parsed;
            try {
              parsed = await compute(parseMcqBundleJsonBatch, raws);
            } catch (e, st) {
              AppLogger.error(
                'MCQ JSON parse error (batch starting ${chunk.first})',
                error: e,
                stackTrace: st,
              );
              return Left(
                AssetFailure(
                  'Failed to parse MCQ bundle batch: $e',
                ),
              );
            }

            final mcqList = (parsed['mcq'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
            final contentList = (parsed['content'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
            final tableList = (parsed['table'] as List<dynamic>)
                .cast<Map<String, dynamic>>();

            try {
              await _db.transaction((txn) async {
                final batch = txn.batch();
                for (final row in mcqList) {
                  batch.insert(
                    'mcq_meta_data',
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
            } catch (e, st) {
              AppLogger.error(
                'MCQ import error',
                error: e,
                stackTrace: st,
              );
              return Left(
                AssetFailure(
                  'Failed to commit MCQ batch (${chunk.first}): $e',
                ),
              );
            }

            completedSlots += chunk.length;
            onProgress(
              McqSeedProgress(
                overallFraction: completedSlots / totalSlots,
                subjectFraction: end / subjectFileCount,
                currentSubjectFolder: folder,
                currentSubjectLabel: label,
              ),
            );
          }
        }
        return const Right(unit);
      } finally {
        await _restoreSqliteAfterBulkImport(_db);
      }
    } catch (e, st) {
      AppLogger.error(
        'MCQ seeding failed',
        error: e,
        stackTrace: st,
      );
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Resolves ordered JSON paths for one subject folder based on [McqSeedConstants.fileCountMode].
  ///
  /// When [fileCountMode] is [McqSeedFileCountMode.allBundledJson], pass [manifest] from a single
  /// [AssetManifest.loadFromAssetBundle] call for the whole seed (avoids re-parsing the manifest per subject).
  Future<List<String>> _jsonAssetPathsForSubjectFolder(
    String folder,
    AssetManifest? manifest,
  ) async {
    final prefix = '${McqSeedConstants.assetRootEn}/$folder/';
    switch (McqSeedConstants.fileCountMode) {
      case McqSeedFileCountMode.cappedSequential:
        return List<String>.generate(
          McqSeedConstants.filesPerSubject,
          (i) => '$prefix${i + 1}.json',
        );
      case McqSeedFileCountMode.allBundledJson:
        final resolved = manifest ??
            await AssetManifest.loadFromAssetBundle(rootBundle);
        final keys = resolved
            .listAssets()
            .where(
              (String key) => key.startsWith(prefix) && key.endsWith('.json'),
            )
            .toList()
          ..sort(_compareQuestionJsonAssetPaths);
        return keys;
    }
  }

  /// Puts `2.json` before `10.json`; non-numeric names sort alphabetically after numeric stems.
  static int _compareQuestionJsonAssetPaths(String a, String b) {
    final fa = a.split('/').last.replaceAll('.json', '');
    final fb = b.split('/').last.replaceAll('.json', '');
    final ia = int.tryParse(fa);
    final ib = int.tryParse(fb);
    if (ia != null && ib != null) {
      return ia.compareTo(ib);
    }
    if (ia != null) {
      return -1;
    }
    if (ib != null) {
      return 1;
    }
    return fa.compareTo(fb);
  }

  /// Faster writes during first-run import; restored before the app uses the DB normally.
  Future<void> _enableSqliteBulkImportMode(Database db) async {
    try {
      await db.execute('PRAGMA synchronous = OFF');
    } catch (e) {
      AppLogger.warning(
        'MCQ seed: PRAGMA synchronous=OFF not applied',
        error: e,
      );
    }
  }

  Future<void> _restoreSqliteAfterBulkImport(Database db) async {
    try {
      await db.execute('PRAGMA synchronous = NORMAL');
    } catch (e) {
      AppLogger.warning(
        'MCQ seed: PRAGMA synchronous restore failed',
        error: e,
      );
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
