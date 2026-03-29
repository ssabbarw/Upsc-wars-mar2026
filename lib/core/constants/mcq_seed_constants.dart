/// How many question JSON files to import per subject on first-time seed.
enum McqSeedFileCountMode {
  /// Loads only sequentially numbered files: `1.json` … [McqSeedConstants.filesPerSubject].json.
  ///
  /// Predictable and fast to configure; does not pick up oddly named files.
  cappedSequential,

  /// Discovers every `*.json` asset under each subject folder via [AssetManifest] (no numeric cap).
  ///
  /// Use this when you add `21.json`, `100.json`, or non-numeric names and want them all imported.
  /// Every file must still be included by a directory entry in `pubspec.yaml` under `assets/`.
  allBundledJson,
}

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

  /// Chooses between a fixed numeric cap and importing every bundled JSON per subject.
  ///
  /// Set to [McqSeedFileCountMode.allBundledJson] for no cap (all declared `*.json` files).
  static const McqSeedFileCountMode fileCountMode =
      McqSeedFileCountMode.allBundledJson;

  /// Inclusive file range: `1.json` … [filesPerSubject].json per subject.
  ///
  /// Used only when [fileCountMode] is [McqSeedFileCountMode.cappedSequential].
  static const int filesPerSubject = 20;

  /// [SharedPreferences] key — when true, bundled MCQ seeding is skipped.
  static const String prefsSeedCompleteKey = 'mcq_en_seed_v1_complete';
}
