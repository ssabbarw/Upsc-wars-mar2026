import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upsc_wars_new/core/constants/app_colors.dart';
import 'package:upsc_wars_new/core/constants/app_sizes.dart';
import 'package:upsc_wars_new/core/providers/database_provider.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/practice_test/data/repositories/practice_test_repository_impl.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_test_outcome.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/widgets/practice_mcq_table.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/widgets/practice_review_explanation_section.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Full explanations for every question in a completed test.
class PracticeTestReviewPage extends HookConsumerWidget {
  /// Creates the review flow; [outcome] is passed via [GoRouterState.extra].
  const PracticeTestReviewPage({super.key, required this.outcome});

  final PracticeTestOutcome? outcome;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final o = outcome;

    if (o == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.practiceTestResultsMissing)),
      );
    }

    final pageIndex = useState(0);
    final bookmarkMap = useState<Map<int, bool>>({
      for (final item in o.items)
        item.question.overallQueNo: item.question.bookmarked,
    });

    Future<void> toggleBookmark(int overallQueNo) async {
      final next = !(bookmarkMap.value[overallQueNo] ?? false);
      final db = await ref.read(appDatabaseProvider.future);
      final repo = PracticeTestRepositoryImpl(db);
      final res = await repo.setBookmarked(
        overallQueNo: overallQueNo,
        bookmarked: next,
      );
      if (!context.mounted) return;
      res.fold((_) {}, (_) {
        bookmarkMap.value = {...bookmarkMap.value, overallQueNo: next};
      });
    }

    final item = o.items[pageIndex.value];
    final q = item.question;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.practiceTestProgress(pageIndex.value + 1, o.items.length),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              key: ValueKey<int>(o.items[pageIndex.value].question.overallQueNo),
              padding: EdgeInsets.fromLTRB(
                context.wp(4),
                context.hp(1),
                context.wp(4),
                context.hp(2),
              ),
              child: _ReviewQuestionBody(
                item: o.items[pageIndex.value],
                l10n: l10n,
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                context.wp(3),
                context.hp(0.5),
                context.wp(3),
                context.hp(1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: pageIndex.value > 0
                          ? () => pageIndex.value = pageIndex.value - 1
                          : null,
                      child: Text(l10n.practiceTestPrev),
                    ),
                  ),
                  SizedBox(width: context.wp(2)),
                  IconButton.filledTonal(
                    onPressed: () => toggleBookmark(q.overallQueNo),
                    icon: Icon(
                      (bookmarkMap.value[q.overallQueNo] ?? false)
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                    ),
                    tooltip: l10n.practiceTestBookmark,
                  ),
                  SizedBox(width: context.wp(2)),
                  Expanded(
                    child: FilledButton(
                      onPressed: pageIndex.value < o.items.length - 1
                          ? () => pageIndex.value = pageIndex.value + 1
                          : null,
                      child: Text(l10n.practiceTestNext),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewQuestionBody extends StatelessWidget {
  const _ReviewQuestionBody({
    required this.item,
    required this.l10n,
  });

  final PracticeQuestionResultItem item;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final q = item.question;
    final user = item.userAnswer;
    final correct = q.correctOption.toLowerCase();

    Widget optionChip(String letter) {
      final lower = letter.toLowerCase();
      final isCorrect = lower == correct;
      final isUser = user == lower;
      Color bg;
      Color fg;
      if (isCorrect) {
        bg = AppColors.success.withValues(alpha: 0.2);
        fg = AppColors.success;
      } else if (isUser) {
        bg = scheme.errorContainer.withValues(alpha: 0.6);
        fg = scheme.error;
      } else {
        bg = scheme.surfaceContainerHighest;
        fg = scheme.onSurfaceVariant;
      }
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.wp(4),
          vertical: context.hp(1.1),
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          border: Border.all(
            color: isCorrect
                ? AppColors.success
                : isUser
                    ? scheme.error
                    : scheme.outlineVariant.withValues(alpha: 0.4),
            width: isCorrect || isUser ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              letter,
              style: TextStyle(
                fontSize: context.sp(17),
                fontWeight: FontWeight.w800,
                color: fg,
              ),
            ),
            if (isUser && !isCorrect) ...[
              SizedBox(width: context.wp(2)),
              Text(
                '(${l10n.practiceTestYourPick})',
                style: TextStyle(
                  fontSize: context.sp(12),
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (isCorrect) ...[
              SizedBox(width: context.wp(2)),
              Text(
                '(${l10n.practiceTestCorrectLabel})',
                style: TextStyle(
                  fontSize: context.sp(12),
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (q.hasTable && q.table != null)
          PracticeMcqTable(data: q.table!)
        else
          Text(
            q.displayText ?? q.questionText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                  fontSize: context.sp(16),
                ),
          ),
        SizedBox(height: context.hp(2)),
        Wrap(
          spacing: context.wp(2),
          runSpacing: context.hp(1),
          children: ['A', 'B', 'C', 'D'].map(optionChip).toList(),
        ),
        SizedBox(height: context.hp(2.5)),
        PracticeReviewExplanationSection(
          item: item,
          l10n: l10n,
        ),
      ],
    );
  }
}
