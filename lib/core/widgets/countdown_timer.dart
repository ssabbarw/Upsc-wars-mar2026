import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';

/// A live countdown that ticks every second and renders:
///
///   55 Days  22 Hr  15 mm  49 ss
///   Left Till Prelims
///
/// Usage:
/// ```dart
/// CountdownTimer(
///   targetDate: AppConstants.upscPrelimsDate,
///   label: 'Left Till Prelims',
/// )
/// ```
class CountdownTimer extends HookWidget {
  const CountdownTimer({
    super.key,
    required this.targetDate,
    required this.label,
    this.expiredText = 'Date has passed',
  });

  /// The date to count down to.
  final DateTime targetDate;

  /// Text shown below the numbers, e.g. "Left Till Prelims".
  final String label;

  /// Text shown when the target date is in the past.
  final String expiredText;

  @override
  Widget build(BuildContext context) {
    final remaining = useState(_remaining());

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        remaining.value = _remaining();
      });
      return timer.cancel;
    }, const []);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool expired = remaining.value == Duration.zero;

    if (expired) {
      return Text(
        expiredText,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: context.sp(16),
        ),
      );
    }

    final double gapBetweenUnits = context.wp(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CountUnit(
                value: remaining.value.inDays,
                label: 'Days',
              ),
              SizedBox(width: gapBetweenUnits),
              _CountUnit(
                value: remaining.value.inHours % 24,
                label: 'Hr',
              ),
              SizedBox(width: gapBetweenUnits),
              _CountUnit(
                value: remaining.value.inMinutes % 60,
                label: 'mm',
              ),
              SizedBox(width: gapBetweenUnits),
              _CountUnit(
                value: remaining.value.inSeconds % 60,
                label: 'ss',
              ),
            ],
          ),
        ),
        SizedBox(height: context.hp(1)),
        Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
            fontSize: context.sp(16),
          ),
        ),
      ],
    );
  }

  Duration _remaining() {
    final diff = targetDate.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }
}

class _CountUnit extends StatelessWidget {
  const _CountUnit({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final double digitFontSize = context.sp(34);
    final double unitLabelFontSize = context.sp(12);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(
            fontSize: digitFontSize,
            color: colorScheme.primary,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
            height: 1,
          ),
        ),
        SizedBox(width: context.wp(0.8)),
        Text(
          label,
          style: TextStyle(
            fontSize: unitLabelFontSize,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
