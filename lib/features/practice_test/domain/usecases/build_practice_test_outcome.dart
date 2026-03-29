import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_question.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_test_outcome.dart';

/// Builds [PracticeTestOutcome] from session answers and elapsed time.
class BuildPracticeTestOutcomeUseCase {
  /// Creates the use case.
  const BuildPracticeTestOutcomeUseCase();

  /// Computes stats and per-type accuracy for attempted questions only.
  PracticeTestOutcome call({
    required String subjectId,
    required int testNumber,
    required List<PracticeQuestion> questions,
    required Map<int, String?> answersByIndex,
    required Duration timeTaken,
  }) {
    final n = questions.length;
    final items = <PracticeQuestionResultItem>[];

    for (var i = 0; i < n; i++) {
      final raw = answersByIndex[i];
      final user = raw?.toLowerCase();
      items.add(
        PracticeQuestionResultItem(
          question: questions[i],
          userAnswer: user,
          wasSkipped: user == null,
        ),
      );
    }

    var correct = 0;
    var incorrect = 0;
    var skipped = 0;
    for (final item in items) {
      if (item.userAnswer == null) {
        skipped++;
      } else if (item.isCorrect) {
        correct++;
      } else {
        incorrect++;
      }
    }

    final accuracyPercent = n == 0 ? 0 : ((correct * 100) / n).round();

    final byType = <String, List<bool>>{};
    for (final item in items) {
      final t = item.question.questionType.trim();
      if (t.isEmpty) continue;
      if (item.userAnswer == null) continue;
      byType.putIfAbsent(t, () => []).add(item.isCorrect);
    }

    final accuracyByQuestionType = <String, int>{};
    for (final e in byType.entries) {
      final list = e.value;
      if (list.isEmpty) continue;
      final c = list.where((v) => v).length;
      accuracyByQuestionType[e.key] = ((c * 100) / list.length).round();
    }

    return PracticeTestOutcome(
      subjectId: subjectId,
      testNumber: testNumber,
      timeTaken: timeTaken,
      totalQuestions: n,
      correctCount: correct,
      incorrectCount: incorrect,
      skippedCount: skipped,
      accuracyPercent: accuracyPercent,
      accuracyByQuestionType: accuracyByQuestionType,
      items: items,
    );
  }
}
