import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upsc_wars_new/core/providers/database_provider.dart';
import 'package:upsc_wars_new/features/subject_tests/data/repositories/subject_tests_repository_impl.dart';
import 'package:upsc_wars_new/features/subject_tests/domain/entities/subject_test_info.dart';
import 'package:upsc_wars_new/features/subject_tests/domain/usecases/list_subject_tests_usecase.dart';

part 'subject_tests_providers.g.dart';

/// Practice tests (25 questions each) for a subject, from local SQLite.
@riverpod
Future<List<SubjectTestInfo>> subjectTestsList(
  SubjectTestsListRef ref,
  String subjectId,
) async {
  final db = await ref.watch(appDatabaseProvider.future);
  final useCase = ListSubjectTestsUseCase(SubjectTestsRepositoryImpl(db));
  final result = await useCase(subjectId);
  return result.fold(
    (f) => throw StateError(f.message),
    (list) => list,
  );
}
