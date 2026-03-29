import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upsc_wars_new/core/providers/database_provider.dart';
import 'package:upsc_wars_new/features/practice_test/data/repositories/practice_test_repository_impl.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_question.dart';

part 'practice_test_questions_provider.g.dart';

/// Loads one 25-question block for the practice UI.
@riverpod
Future<List<PracticeQuestion>> practiceTestQuestions(
  PracticeTestQuestionsRef ref,
  String subjectId,
  int testNumber,
) async {
  final db = await ref.watch(appDatabaseProvider.future);
  final repo = PracticeTestRepositoryImpl(db);
  final result = await repo.loadTestQuestions(
    subjectId: subjectId,
    testNumber: testNumber,
  );
  return result.fold(
    (f) => throw StateError(f.message),
    (list) => list,
  );
}
