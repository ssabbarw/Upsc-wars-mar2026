import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/home/data/datasources/subjects_datasource.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_item.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_list_source.dart';
import 'package:upsc_wars_new/features/topic_wise/presentation/providers/topic_wise_browse_providers.dart';
import 'package:upsc_wars_new/features/topic_wise/presentation/widgets/topic_wise_subject_strip.dart';
import 'package:upsc_wars_new/features/topic_wise/presentation/widgets/topic_wise_tag_list_section.dart';
import 'package:upsc_wars_new/features/topic_wise/presentation/widgets/topic_wise_tag_search_bar.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Browse MCQs by topic, sub-topic, or concept (driven by config asset).
class TopicWiseBrowsePage extends HookConsumerWidget {
  /// Creates the topic-wise browse screen.
  const TopicWiseBrowsePage({super.key});

  static const Color _accent = Color(0xFF4527A0);

  static String _groupingLabel(
    AppLocalizations l10n,
    TopicWiseTagListSource source,
  ) {
    switch (source) {
      case TopicWiseTagListSource.topic:
        return l10n.topicWiseBrowseGroupingTopic;
      case TopicWiseTagListSource.subTopic:
        return l10n.topicWiseBrowseGroupingSubTopic;
      case TopicWiseTagListSource.concepts:
        return l10n.topicWiseBrowseGroupingConcepts;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final subjects = SubjectsDataSource.all;
    final selectedId = useState(subjects.first.id);
    final searchController = useTextEditingController();
    useListenable(searchController);

    final asyncItems = ref.watch(
      topicWiseTagItemsForSubjectProvider(selectedId.value),
    );
    final sourceAsync = ref.watch(topicWiseTagListSourceProvider);

    final query = searchController.text.trim().toLowerCase();

    void onTagTap(TopicWiseTagItem _) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.topicWiseBrowseTagTapSoon),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.topicWiseBrowseTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopicWiseSubjectStrip(
            subjects: subjects,
            selectedSubjectId: selectedId.value,
            onSelect: (id) => selectedId.value = id,
            accentColor: _accent,
            l10n: l10n,
          ),
          sourceAsync.maybeWhen(
            data: (source) => Padding(
              padding: EdgeInsets.fromLTRB(
                context.wp(4),
                0,
                context.wp(4),
                context.hp(0.3),
              ),
              child: Text(
                _groupingLabel(l10n, source),
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: context.sp(12),
                  color: theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.wp(4),
              context.hp(0.5),
              context.wp(4),
              context.hp(0.5),
            ),
            child: TopicWiseTagSearchBar(
              controller: searchController,
              hintText: l10n.topicWiseBrowseSearchHint,
              accentColor: _accent,
            ),
          ),
          Expanded(
            child: asyncItems.when(
              data: (items) {
                final filtered = query.isEmpty
                    ? items
                    : items
                        .where(
                          (t) => t.label.toLowerCase().contains(query),
                        )
                        .toList();
                return TopicWiseTagListSection(
                  items: filtered,
                  allCount: items.length,
                  query: query,
                  l10n: l10n,
                  accentColor: _accent,
                  onTagTap: onTagTap,
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (_, __) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
                  child: Text(
                    l10n.topicWiseBrowseLoadError,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
