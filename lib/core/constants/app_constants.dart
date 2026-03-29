/// App-wide constants that don't belong to a specific feature.
abstract final class AppConstants {
  /// UPSC Prelims exam date as a Unix timestamp in milliseconds.
  /// To update the target date, change only this value.
  static const int upscPrelimsTimestampMs = 1779593400000;

  static DateTime get upscPrelimsDate =>
      DateTime.fromMillisecondsSinceEpoch(upscPrelimsTimestampMs);
}
