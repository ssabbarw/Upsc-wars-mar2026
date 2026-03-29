import 'package:flutter/material.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/home/domain/entities/subject.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Horizontal scrollable subject selector for topic-wise browse.
class TopicWiseSubjectStrip extends StatelessWidget {
  /// Creates the strip.
  const TopicWiseSubjectStrip({
    super.key,
    required this.subjects,
    required this.selectedSubjectId,
    required this.onSelect,
    required this.accentColor,
    required this.l10n,
  });

  /// Same order as the home subject list.
  final List<Subject> subjects;

  /// Currently selected [Subject.id].
  final String selectedSubjectId;

  /// Called when the user selects a subject chip.
  final ValueChanged<String> onSelect;

  /// Accent used for the selected chip (matches topic-wise tile).
  final Color accentColor;

  /// Localizations for subject display names.
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: context.hp(11),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.wp(4),
          vertical: context.hp(0.8),
        ),
        itemCount: subjects.length,
        separatorBuilder: (_, __) => SizedBox(width: context.wp(2)),
        itemBuilder: (context, index) {
          final subject = subjects[index];
          final selected = subject.id == selectedSubjectId;
          final bgAlpha = isDark ? 50 : 36;
          final baseBg = subject.color.withAlpha(bgAlpha);

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onSelect(subject.id),
              borderRadius: BorderRadius.circular(context.wp(4)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.symmetric(
                  horizontal: context.wp(3),
                  vertical: context.hp(0.6),
                ),
                decoration: BoxDecoration(
                  color: selected ? accentColor.withAlpha(isDark ? 55 : 28) : baseBg,
                  borderRadius: BorderRadius.circular(context.wp(4)),
                  border: Border.all(
                    color: selected
                        ? accentColor
                        : colorScheme.outline.withAlpha(isDark ? 90 : 50),
                    width: selected ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      subject.icon,
                      size: context.sp(20),
                      color: selected ? accentColor : subject.color,
                    ),
                    SizedBox(width: context.wp(2)),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: context.wp(28)),
                      child: Text(
                        subject.name(l10n),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: context.sp(12),
                          color: selected
                              ? accentColor
                              : colorScheme.onSurface,
                          height: 1.15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
