/// Asset layout and seeding parameters for bundled English MCQs.
abstract final class McqSeedConstants {
  McqSeedConstants._();

  /// Root path for English question JSON (matches [pubspec.yaml] asset entries).
  static const String assetRootEn = 'assets/questions/en';

  /// Subject folder names under [assetRootEn] (must match declared Flutter assets).
  static const List<String> subjectFolders = [
    'ancient_history',
    'art_and_culture',
    'economy',
    'environment',
    'geography',
    'medieval_history',
    'modern_history',
    'polity',
  ];

  /// Inclusive file range: `1.json` … [filesPerSubject].json per subject.
  static const int filesPerSubject = 20;

  /// [SharedPreferences] key — when true, bundled MCQ seeding is skipped.
  static const String prefsSeedCompleteKey = 'mcq_en_seed_v1_complete';
}
