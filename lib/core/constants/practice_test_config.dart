/// Timing for subject practice tests (see [SubjectTestConstants.questionsPerTest]).
///
/// Change [testDuration] while debugging (e.g. to [Duration(seconds: 45)]).
abstract final class PracticeTestConfig {
  PracticeTestConfig._();

  /// Total time for one full test. When it elapses, answers are locked and the
  /// test auto-submits.
  static const Duration testDuration = Duration(minutes: 30);
}
