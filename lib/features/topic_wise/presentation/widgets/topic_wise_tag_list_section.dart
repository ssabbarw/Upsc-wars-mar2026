import 'package:flutter/material.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_item.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Scrollable list of tags with empty / no-match states.
class TopicWiseTagListSection extends StatelessWidget {
  /// Creates the list section.
  const TopicWiseTagListSection({
    super.key,
    required this.items,
    required this.allCount,
    required this.query,
    required this.l10n,
    required this.accentColor,
    required this.onTagTap,
  });

  /// After applying the search [query].
  final List<TopicWiseTagItem> items;

  /// Count before filtering (for empty-subject message).
  final int allCount;

  /// Normalized search text (lowercase trim).
  final String query;

  final AppLocalizations l10n;

  final Color accentColor;

  /// When user taps a row (e.g. future navigation).
  final void Function(TopicWiseTagItem item) onTagTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (allCount == 0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wp(10)),
          child: Text(
            l10n.topicWiseBrowseEmptySubject,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: context.sp(16),
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wp(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.manage_search_rounded,
                size: context.sp(48),
                color: colorScheme.outline,
              ),
              SizedBox(height: context.hp(1.5)),
              Text(
                l10n.topicWiseBrowseEmptyFilter,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: context.sp(17),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        context.wp(4),
        context.hp(0.5),
        context.wp(4),
        context.hp(2),
      ),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: context.hp(0.6)),
      itemBuilder: (context, index) {
        final item = items[index];
        return Material(
          color: colorScheme.surfaceContainerLow,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.wp(3)),
            side: BorderSide(
              color: colorScheme.outline.withAlpha(45),
            ),
          ),
          child: InkWell(
            onTap: () => onTagTap(item),
            borderRadius: BorderRadius.circular(context.wp(3)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.wp(4),
                vertical: context.hp(1.2),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.wp(2),
                    height: context.hp(2.5),
                    decoration: BoxDecoration(
                      color: accentColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: context.wp(3)),
                  Expanded(
                    child: Text(
                      item.label,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: context.sp(15),
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                  ),
                  SizedBox(width: context.wp(2)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.wp(2.5),
                      vertical: context.hp(0.4),
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withAlpha(
                        theme.brightness == Brightness.dark ? 40 : 24,
                      ),
                      borderRadius: BorderRadius.circular(context.wp(5)),
                    ),
                    child: Text(
                      l10n.topicWiseBrowseQuestionCount(item.questionCount),
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontSize: context.sp(12),
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
