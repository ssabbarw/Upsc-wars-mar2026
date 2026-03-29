import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upsc_wars_new/core/providers/database_provider.dart';
import 'package:upsc_wars_new/features/topic_wise/data/datasources/topic_wise_browse_config_asset_datasource.dart';
import 'package:upsc_wars_new/features/topic_wise/data/repositories/topic_wise_tags_repository_impl.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_item.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_list_source.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/usecases/get_topic_wise_tag_items_for_subject_usecase.dart';

part 'topic_wise_browse_providers.g.dart';

/// Parsed `tagListSource` from [TopicWiseBrowseConstants.configAssetPath].
@Riverpod(keepAlive: true)
Future<TopicWiseTagListSource> topicWiseTagListSource(
  TopicWiseTagListSourceRef ref,
) async {
  const dataSource = TopicWiseBrowseConfigAssetDataSource();
  final result = await dataSource.loadTagListSource();
  return result.fold(
    (failure) => throw StateError(failure.message),
    (source) => source,
  );
}

/// Distinct tags for [subjectId] using the configured list source.
@riverpod
Future<List<TopicWiseTagItem>> topicWiseTagItemsForSubject(
  TopicWiseTagItemsForSubjectRef ref,
  String subjectId,
) async {
  final db = await ref.watch(appDatabaseProvider.future);
  final source = await ref.watch(topicWiseTagListSourceProvider.future);
  final repository = TopicWiseTagsRepositoryImpl(db);
  final useCase = GetTopicWiseTagItemsForSubjectUseCase(repository);
  final result = await useCase(subjectId: subjectId, source: source);
  return result.fold(
    (failure) => throw StateError(failure.message),
    (items) => items,
  );
}
