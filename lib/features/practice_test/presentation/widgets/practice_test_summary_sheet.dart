import 'package:flutter/material.dart';
import 'package:upsc_wars_new/core/constants/app_sizes.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Bottom sheet with a 5×5 grid of question indices and a legend.
class PracticeTestSummarySheet extends StatelessWidget {
  /// Creates the palette navigator sheet.
  const PracticeTestSummarySheet({
    super.key,
    required this.total,
    required this.currentIndex,
    required this.answeredIndices,
    required this.skippedIndices,
    required this.revisitIndices,
    required this.onPick,
    required this.l10n,
  });

  final int total;
  final int currentIndex;
  final Set<int> answeredIndices;
  final Set<int> skippedIndices;
  final Set<int> revisitIndices;
  final void Function(int index) onPick;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Color cellColor(int i) {
      if (answeredIndices.contains(i)) return scheme.primary;
      if (skippedIndices.contains(i)) return scheme.tertiary;
      return scheme.surfaceContainerHighest;
    }

    Color onCellColor(int i) {
      if (answeredIndices.contains(i) || skippedIndices.contains(i)) {
        return scheme.onPrimary;
      }
      return scheme.onSurfaceVariant;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.wp(4),
        context.hp(1),
        context.wp(4),
        context.hp(2) + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: context.wp(10),
              height: 1,
              decoration: BoxDecoration(
                color: scheme.onSurfaceVariant.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
          SizedBox(height: context.hp(1.8)),
          Text(
            l10n.practiceTestSummaryTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.hp(2)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: AppSizes.sm,
              crossAxisSpacing: AppSizes.sm,
              childAspectRatio: 1,
            ),
            itemCount: total,
            itemBuilder: (context, index) {
              final isCurrent = index == currentIndex;
              return Material(
                color: cellColor(index),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                elevation: isCurrent ? 2 : 0,
                shadowColor: scheme.shadow.withValues(alpha: 0.2),
                child: InkWell(
                  onTap: () => onPick(index),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      border: Border.all(
                        color: isCurrent
                            ? scheme.secondary
                            : revisitIndices.contains(index)
                                ? scheme.secondary
                                    .withValues(alpha: 0.55)
                                : Colors.transparent,
                        width: isCurrent
                            ? 2
                            : revisitIndices.contains(index)
                                ? 1.5
                                : 0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: onCellColor(index),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: context.hp(2)),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: context.wp(4),
            runSpacing: context.hp(0.8),
            children: [
              _LegendDot(
                color: scheme.primary,
                label: l10n.practiceTestLegendAnswered,
              ),
              _LegendDot(
                color: scheme.tertiary,
                label: l10n.practiceTestLegendSkipped,
              ),
              _LegendDot(
                color: scheme.surfaceContainerHighest,
                label: l10n.practiceTestLegendPending,
              ),
              _LegendDot(
                color: scheme.secondary.withValues(alpha: 0.5),
                label: l10n.practiceTestLegendRevisit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: context.wp(1.5)),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
