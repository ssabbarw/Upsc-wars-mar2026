/// Which field from `mcq_meta_data` drives the browse list (see asset config).
enum TopicWiseTagListSource {
  /// Distinct `topic` values.
  topic,

  /// Distinct `sub_topic` values (non-empty).
  subTopic,

  /// Distinct strings from the JSON array in `concepts_used`.
  concepts;

  /// Parses [raw] from `topic_wise_browse_config.json`. Unknown values fall back to [topic].
  static TopicWiseTagListSource fromConfigString(String raw) {
    switch (raw.trim()) {
      case 'sub_topic':
        return TopicWiseTagListSource.subTopic;
      case 'concepts':
        return TopicWiseTagListSource.concepts;
      case 'topic':
      default:
        return TopicWiseTagListSource.topic;
    }
  }
}
