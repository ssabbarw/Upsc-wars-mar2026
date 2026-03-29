import 'package:fpdart/fpdart.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/subject_tests/domain/entities/subject_test_info.dart';
import 'package:upsc_wars_new/features/subject_tests/domain/repositories/subject_tests_repository.dart';

/// Returns practice test metadata for a subject (25-question blocks only).
class ListSubjectTestsUseCase {
  /// Creates the use case with a [SubjectTestsRepository].
  const ListSubjectTestsUseCase(this._repository);

  final SubjectTestsRepository _repository;

  /// Lists full tests for [subjectId].
  Future<Either<Failure, List<SubjectTestInfo>>> call(String subjectId) {
    return _repository.listFullTests(subjectId);
  }
}
