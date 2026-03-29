/// Maps home / UI subject ids to the `mcq.subject` column values stored from JSON.
abstract final class SubjectMcqDbNames {
  SubjectMcqDbNames._();

  static const Map<String, String> _byId = {
    'geography': 'Geography',
    'modern_history': 'Modern History',
    'polity': 'Polity',
    'medieval_history': 'Medieval History',
    'art_and_culture': 'Art and Culture',
    'economics': 'Economy',
    'environment': 'Environment',
    'ancient_history': 'Ancient History',
  };

  /// SQLite `subject` value for [subjectId], or `null` if unknown.
  static String? dbSubjectForId(String subjectId) => _byId[subjectId];
}
