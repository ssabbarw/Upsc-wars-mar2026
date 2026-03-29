import 'package:fpdart/fpdart.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/subject_tests/domain/entities/subject_test_info.dart';

/// Read-only access to subject-scoped MCQ counts for building practice tests.
abstract interface class SubjectTestsRepository {
  /// Full tests only: `floor(questionCount / 25)`; remainder discarded.
  Future<Either<Failure, List<SubjectTestInfo>>> listFullTests(String subjectId);
}
