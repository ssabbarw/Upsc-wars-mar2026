import 'package:flutter/widgets.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';

/// Renders a different widget tree depending on screen width.
///
/// Use this at the **page level** to swap entire layouts between form factors.
/// For small inline decisions (padding, column count, font size) prefer
/// `Responsive.of(context).when(mobile: ..., tablet: ...)` instead.
///
/// ```dart
/// ResponsiveLayout(
///   mobile: const MobileHomeLayout(),
///   tablet: const TabletHomeLayout(),
/// )
/// ```
///
/// If [tablet] is omitted, falls back to [mobile] on tablet.
/// If [desktop] is omitted, falls back to [tablet] (or [mobile]) on desktop.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width >= Breakpoints.desktop && desktop != null) return desktop!;
        if (width >= Breakpoints.tablet && tablet != null) return tablet!;
        return mobile;
      },
    );
  }
}
