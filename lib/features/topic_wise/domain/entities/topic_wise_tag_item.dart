/// One row in the topic-wise browse list: label plus how many questions reference it.
class TopicWiseTagItem {
  /// Creates a tag row for the browse UI.
  const TopicWiseTagItem({
    required this.label,
    required this.questionCount,
  });

  /// Topic, sub-topic label, or single concept string.
  final String label;

  /// Number of questions in the DB for the selected subject that use this tag.
  final int questionCount;
}
