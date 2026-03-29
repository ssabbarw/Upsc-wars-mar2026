import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upsc_wars_new/core/constants/subject_mcq_db_names.dart';
import 'package:upsc_wars_new/core/constants/subject_test_constants.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/subject_tests/domain/entities/subject_test_info.dart';
import 'package:upsc_wars_new/features/subject_tests/domain/repositories/subject_tests_repository.dart';

/// [SubjectTestsRepository] backed by the local `mcq` table.
class SubjectTestsRepositoryImpl implements SubjectTestsRepository {
  /// Creates the repository with an open [Database].
  SubjectTestsRepositoryImpl(this._db);

  final Database _db;

  @override
  Future<Either<Failure, List<SubjectTestInfo>>> listFullTests(
    String subjectId,
  ) async {
    final dbSubject = SubjectMcqDbNames.dbSubjectForId(subjectId);
    if (dbSubject == null) {
      return left(const CacheFailure('Unknown subject id'));
    }

    try {
      final rows = await _db.rawQuery(
        'SELECT COUNT(*) AS c FROM mcq WHERE subject = ?',
        [dbSubject],
      );
      final total = Sqflite.firstIntValue(rows) ?? 0;
      final fullTests = total ~/ SubjectTestConstants.questionsPerTest;
      if (fullTests == 0) {
        return right(<SubjectTestInfo>[]);
      }

      final list = <SubjectTestInfo>[];
      const q = SubjectTestConstants.questionsPerTest;
      for (var i = 0; i < fullTests; i++) {
        final start = i * q + 1;
        final end = (i + 1) * q;
        list.add(
          SubjectTestInfo(
            testNumber: i + 1,
            firstQuestionOrdinal: start,
            lastQuestionOrdinal: end,
          ),
        );
      }
      return right(list);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}
