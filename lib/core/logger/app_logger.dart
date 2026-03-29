import 'dart:developer' as developer;

/// Thin wrapper around [developer.log] — never use [print] in app code.
abstract final class AppLogger {
  static void debug(String message, {String? name}) {
    developer.log(message, name: name ?? 'UPSCWars');
  }

  static void warning(String message, {String? name, Object? error}) {
    developer.log(
      message,
      name: name ?? 'UPSCWars',
      level: 900, // warning
      error: error,
    );
  }

  static void error(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: name ?? 'UPSCWars',
      level: 1000, // severe
      error: error,
      stackTrace: stackTrace,
    );
  }
}
