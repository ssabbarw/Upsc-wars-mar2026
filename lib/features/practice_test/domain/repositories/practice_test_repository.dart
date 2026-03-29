import 'package:fpdart/fpdart.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_question.dart';

/// Loads practice blocks and updates bookmark flags in `mcq_meta_data`.
abstract interface class PracticeTestRepository {
  /// Loads [PracticeTestConfig.questionsPerTest] rows for [testNumber] (1-based).
  Future<Either<Failure, List<PracticeQuestion>>> loadTestQuestions({
    required String subjectId,
    required int testNumber,
  });

  /// Persists bookmark state for a single question.
  Future<Either<Failure, Unit>> setBookmarked({
    required int overallQueNo,
    required bool bookmarked,
  });
}
