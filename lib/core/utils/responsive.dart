import 'package:flutter/widgets.dart';

/// Screen-width breakpoints used across the app.
/// Both [Responsive] and [ResponsiveLayout] reference these constants so
/// breakpoints stay consistent if you ever need to adjust them.
abstract final class Breakpoints {
  static const double small = 360; // very small phones
  static const double tablet = 600; // tablets / large-phone landscape
  static const double desktop = 1024; // desktop / large tablets
}

/// Utility class for making layout decisions based on screen width.
///
/// Usage:
/// ```dart
/// final r = Responsive.of(context);
///
/// // Boolean checks
/// if (r.isTablet) { ... }
///
/// // Value switch — always provide [mobile]; others fall back to it
/// final columns = r.when(mobile: 1, tablet: 2, desktop: 3);
///
/// // Quick static access
/// final width = Responsive.screenWidth(context);
/// ```
class Responsive {
  const Responsive._({required double width, required double height})
      : _width = width,
        _height = height;

  factory Responsive.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Responsive._(width: size.width, height: size.height);
  }

  final double _width;
  final double _height;

  // ─── Breakpoint checks ───────────────────────────────────────────────────

  /// < 360dp — very small / low-end phones
  bool get isSmall => _width < Breakpoints.small;

  /// 360dp – 599dp — standard phones
  bool get isMobile =>
      _width >= Breakpoints.small && _width < Breakpoints.tablet;

  /// 600dp – 1023dp — tablets and large-phone landscape
  bool get isTablet =>
      _width >= Breakpoints.tablet && _width < Breakpoints.desktop;

  /// >= 1024dp — desktop and large tablets
  bool get isDesktop => _width >= Breakpoints.desktop;

  /// Returns [desktop] if desktop, [tablet] if tablet, otherwise [mobile].
  /// Unspecified breakpoints fall back to [mobile].
  T when<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  // ─── Proportional sizing (instance) ──────────────────────────────────────

  /// Returns [percent]% of screen height.
  ///
  /// Example: `r.hp(10)` → 10% of screen height
  double hp(double percent) => _height * percent / 100;

  /// Returns [percent]% of screen width.
  ///
  /// Example: `r.wp(50)` → 50% of screen width
  double wp(double percent) => _width * percent / 100;

  /// Returns a font size scaled relative to screen width.
  /// Baseline device width is 375dp (iPhone SE / standard design canvas).
  ///
  /// Example: `r.sp(16)` → 16 scaled to current screen width
  double sp(double size) => size * _width / 375;

  // ─── Static helpers ───────────────────────────────────────────────────────

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;
}

/// Convenience extension on [BuildContext] for proportional sizing.
///
/// Prefer this in widget [build] methods to avoid creating a [Responsive]
/// instance when you only need sizing — not breakpoint checks.
///
/// Usage:
/// ```dart
/// SizedBox(height: context.hp(10))   // 10% of screen height
/// SizedBox(width: context.wp(50))    // 50% of screen width
/// Text('Hi', style: TextStyle(fontSize: context.sp(16)))
/// ```
extension ResponsiveExtension on BuildContext {
  /// Returns [percent]% of screen height.
  double hp(double percent) => MediaQuery.sizeOf(this).height * percent / 100;

  /// Returns [percent]% of screen width.
  double wp(double percent) => MediaQuery.sizeOf(this).width * percent / 100;

  /// Returns a font size scaled relative to screen width (baseline: 375dp).
  double sp(double size) => size * MediaQuery.sizeOf(this).width / 375;
}
