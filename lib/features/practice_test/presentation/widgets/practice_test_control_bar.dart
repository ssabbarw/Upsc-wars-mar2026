import 'package:flutter/material.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Floating bar: revisit checkbox, centered timer, submit (reference layout).
class PracticeTestControlBar extends StatelessWidget {
  /// Creates the session control strip under the app bar.
  const PracticeTestControlBar({
    super.key,
    required this.l10n,
    required this.locked,
    required this.remaining,
    required this.isMarkedRevisit,
    required this.onRevisitMarked,
    required this.onSubmit,
    required this.timerMinutes,
    required this.timerSeconds,
  });

  final AppLocalizations l10n;
  final bool locked;
  final Duration remaining;
  final bool isMarkedRevisit;
  final void Function(bool marked) onRevisitMarked;
  final VoidCallback onSubmit;
  final String timerMinutes;
  final String timerSeconds;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = scheme.secondary;
    final urgent = remaining.inMinutes < 2;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.wp(3.5),
        context.hp(0.9),
        context.wp(3.5),
        context.hp(1.2),
      ),
      child: Material(
        elevation: 2,
        shadowColor: scheme.shadow.withValues(alpha: 0.12),
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.wp(3)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.wp(2.5),
            vertical: context.hp(1.1),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: locked
                    ? null
                    : () => onRevisitMarked(!isMarkedRevisit),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.hp(0.4),
                    horizontal: context.wp(0.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.practiceTestRevisit,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: accent,
                              fontWeight: FontWeight.w600,
                              fontSize: context.sp(14),
                            ),
                      ),
                      SizedBox(width: context.wp(0.6)),
                      SizedBox(
                        width: context.wp(8),
                        height: context.hp(4),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            checkboxTheme: CheckboxThemeData(
                              fillColor:
                                  WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.selected)) {
                                  return accent;
                                }
                                return null;
                              }),
                              checkColor:
                                  WidgetStateProperty.all(scheme.onSecondary),
                            ),
                          ),
                          child: Checkbox(
                            value: isMarkedRevisit,
                            onChanged: locked
                                ? null
                                : (v) {
                                    if (v != null) onRevisitMarked(v);
                                  },
                            side: BorderSide(
                              color: scheme.onSurface.withValues(alpha: 0.45),
                              width: 1.5,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    l10n.practiceTestTimer(timerMinutes, timerSeconds),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: context.sp(20),
                          height: 1.1,
                          fontFeatures: const [FontFeature.tabularFigures()],
                          color: urgent ? scheme.error : scheme.onSurface,
                        ),
                  ),
                ),
              ),
              TextButton(
                onPressed: locked ? null : onSubmit,
                style: TextButton.styleFrom(
                  foregroundColor: accent,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.wp(1.2),
                    vertical: context.hp(0.6),
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  l10n.practiceTestSubmit,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: context.sp(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
