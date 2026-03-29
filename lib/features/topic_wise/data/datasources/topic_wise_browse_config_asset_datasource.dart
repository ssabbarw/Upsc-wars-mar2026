import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:upsc_wars_new/core/constants/topic_wise_browse_constants.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_list_source.dart';

/// Loads [TopicWiseTagListSource] from bundled JSON config.
class TopicWiseBrowseConfigAssetDataSource {
  /// Creates the datasource (stateless).
  const TopicWiseBrowseConfigAssetDataSource();

  /// Reads `assets/config/topic_wise_browse_config.json`.
  Future<Either<Failure, TopicWiseTagListSource>> loadTagListSource() async {
    try {
      final raw = await rootBundle.loadString(
        TopicWiseBrowseConstants.configAssetPath,
      );
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return left(
          const AssetFailure('topic_wise_browse_config.json must be an object'),
        );
      }
      final key = decoded['tagListSource'] ?? decoded['tag_list_source'];
      final str = key is String ? key : 'topic';
      return right(TopicWiseTagListSource.fromConfigString(str));
    } on FlutterError catch (e) {
      return left(
        AssetFailure('Missing topic browse config asset: $e'),
      );
    } catch (e) {
      return left(
        AssetFailure('Invalid topic browse config: $e'),
      );
    }
  }
}
