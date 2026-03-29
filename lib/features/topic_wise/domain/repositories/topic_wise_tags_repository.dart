import 'package:fpdart/fpdart.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_item.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_list_source.dart';

/// Reads tag lists derived from seeded `mcq_meta_data` rows.
abstract interface class TopicWiseTagsRepository {
  /// Returns distinct tags for [dbSubjectName] (SQLite `subject` column value).
  Future<Either<Failure, List<TopicWiseTagItem>>> listTagItems({
    required String dbSubjectName,
    required TopicWiseTagListSource source,
  });
}
