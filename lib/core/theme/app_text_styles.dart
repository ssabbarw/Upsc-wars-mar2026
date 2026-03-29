import 'package:flutter/material.dart';

/// Typography definitions for the app.
///
/// To swap fonts app-wide, change [_fontFamily] to your font name
/// (e.g., 'Poppins', 'Inter') after adding it to pubspec.yaml.
/// Nothing else in the codebase needs to change.
abstract final class AppTextStyles {
  /// Set to a custom font family name to swap the entire app's typography.
  /// null = Material default (Roboto on Android, SF Pro on iOS).
  static const String? _fontFamily = null;

  static TextTheme buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: _style(57, FontWeight.w400, -0.25, colorScheme.onSurface),
      displayMedium: _style(45, FontWeight.w400, 0, colorScheme.onSurface),
      displaySmall: _style(36, FontWeight.w400, 0, colorScheme.onSurface),
      headlineLarge: _style(32, FontWeight.w700, 0, colorScheme.onSurface),
      headlineMedium: _style(28, FontWeight.w700, 0, colorScheme.onSurface),
      headlineSmall: _style(24, FontWeight.w600, 0, colorScheme.onSurface),
      titleLarge: _style(22, FontWeight.w600, 0, colorScheme.onSurface),
      titleMedium: _style(16, FontWeight.w600, 0.15, colorScheme.onSurface),
      titleSmall: _style(14, FontWeight.w500, 0.1, colorScheme.onSurface),
      bodyLarge: _style(16, FontWeight.w400, 0.15, colorScheme.onSurface),
      bodyMedium: _style(14, FontWeight.w400, 0.25, colorScheme.onSurface),
      bodySmall: _style(12, FontWeight.w400, 0.4, colorScheme.onSurfaceVariant),
      labelLarge: _style(14, FontWeight.w600, 0.1, colorScheme.onSurface),
      labelMedium: _style(12, FontWeight.w500, 0.5, colorScheme.onSurface),
      labelSmall: _style(11, FontWeight.w500, 0.5, colorScheme.onSurfaceVariant),
    );
  }

  static TextStyle _style(
    double size,
    FontWeight weight,
    double letterSpacing,
    Color color,
  ) =>
      TextStyle(
        fontFamily: _fontFamily,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: letterSpacing,
        color: color,
      );
}
