import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_question.dart';

/// Immutable result of a submitted practice test (results + review screens).
class PracticeTestOutcome {
  /// Creates an outcome after the timer ends or the user submits.
  const PracticeTestOutcome({
    required this.subjectId,
    required this.testNumber,
    required this.timeTaken,
    required this.totalQuestions,
    required this.correctCount,
    required this.incorrectCount,
    required this.skippedCount,
    required this.accuracyPercent,
    required this.accuracyByQuestionType,
    required this.items,
  });

  final String subjectId;
  final int testNumber;
  final Duration timeTaken;
  final int totalQuestions;
  final int correctCount;
  final int incorrectCount;
  final int skippedCount;

  /// `correctCount / totalQuestions * 100`, rounded.
  final int accuracyPercent;

  /// Keys are [PracticeQuestion.questionType] values that appeared in the test.
  final Map<String, int> accuracyByQuestionType;

  final List<PracticeQuestionResultItem> items;
}

/// Per-question row for results and explanation review.
class PracticeQuestionResultItem {
  /// Creates one row in the outcome list.
  const PracticeQuestionResultItem({
    required this.question,
    required this.userAnswer,
    required this.wasSkipped,
  });

  final PracticeQuestion question;

  /// Lowercase `a`–`d`, or `null` if unanswered at submit.
  final String? userAnswer;
  final bool wasSkipped;

  /// Whether the user answered and matched [PracticeQuestion.correctOption].
  bool get isCorrect =>
      userAnswer != null &&
      userAnswer == question.correctOption.toLowerCase();

  /// User chose an option but it was wrong.
  bool get isIncorrect => userAnswer != null && !isCorrect;
}
