/// Shared [Duration] values for navigation and splash timing.
abstract final class AppDurations {
  AppDurations._();

  /// Minimum time the splash stays visible when bootstrap is very fast.
  static const Duration splashMinimum = Duration(milliseconds: 600);
}
