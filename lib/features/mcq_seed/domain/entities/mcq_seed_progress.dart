/// Snapshot of MCQ asset seeding progress for the splash / loading UI.
class McqSeedProgress {
  /// Creates a progress snapshot.
  const McqSeedProgress({
    required this.overallFraction,
    required this.subjectFraction,
    required this.currentSubjectFolder,
    required this.currentSubjectLabel,
  });

  /// Overall completion in `[0, 1]` across all subjects and file slots.
  final double overallFraction;

  /// Completion in `[0, 1]` for the subject currently being processed.
  final double subjectFraction;

  /// Asset folder key (e.g. `modern_history`).
  final String currentSubjectFolder;

  /// Display-friendly subject title derived from [currentSubjectFolder].
  final String currentSubjectLabel;
}
