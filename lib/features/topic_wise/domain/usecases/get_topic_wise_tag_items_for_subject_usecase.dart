import 'package:fpdart/fpdart.dart';
import 'package:upsc_wars_new/core/constants/subject_mcq_db_names.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_item.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_list_source.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/repositories/topic_wise_tags_repository.dart';

/// Resolves [subjectId] to DB subject name and loads tag rows for [source].
class GetTopicWiseTagItemsForSubjectUseCase {
  /// Creates the use case with a [TopicWiseTagsRepository].
  const GetTopicWiseTagItemsForSubjectUseCase(this._repository);

  final TopicWiseTagsRepository _repository;

  /// Loads tags for the home [subjectId] (e.g. `polity`).
  Future<Either<Failure, List<TopicWiseTagItem>>> call({
    required String subjectId,
    required TopicWiseTagListSource source,
  }) async {
    final dbName = SubjectMcqDbNames.dbSubjectForId(subjectId);
    if (dbName == null) {
      return left(const CacheFailure('Unknown subject id'));
    }
    return _repository.listTagItems(
      dbSubjectName: dbName,
      source: source,
    );
  }
}
