/// Asset path for topic-wise browse configuration (tag source: topic / sub_topic / concepts).
abstract final class TopicWiseBrowseConstants {
  TopicWiseBrowseConstants._();

  /// JSON file: `{ "tagListSource": "topic" | "sub_topic" | "concepts" }`
  static const String configAssetPath =
      'assets/config/topic_wise_browse_config.json';
}
