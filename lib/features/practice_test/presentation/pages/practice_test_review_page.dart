import 'dart:convert';

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

    final controller = usePageController();
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
            child: PageView.builder(
              controller: controller,
              itemCount: o.items.length,
              onPageChanged: (i) => pageIndex.value = i,
              itemBuilder: (context, index) {
                final it = o.items[index];
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    context.wp(4),
                    context.hp(1),
                    context.wp(4),
                    context.hp(2),
                  ),
                  child: _ReviewQuestionBody(
                    item: it,
                    l10n: l10n,
                  ),
                );
              },
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
                          ? () {
                              controller.previousPage(
                                duration: const Duration(milliseconds: 280),
                                curve: Curves.easeOutCubic,
                              );
                            }
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
                          ? () {
                              controller.nextPage(
                                duration: const Duration(milliseconds: 280),
                                curve: Curves.easeOutCubic,
                              );
                            }
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
        Text(
          q.finalExplanation ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.55,
                fontSize: context.sp(15),
              ),
        ),
        if (q.upscTrapExplanation != null &&
            q.upscTrapExplanation!.trim().isNotEmpty)
          _CollapsibleBlock(
            title: l10n.practiceTestCollapsibleTrap,
            child: Text(
              q.upscTrapExplanation!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
            ),
          ),
        if (q.strongDistractor != null &&
            q.strongDistractor!.trim().isNotEmpty)
          _CollapsibleBlock(
            title: l10n.practiceTestCollapsibleDistractor,
            child: Text(
              q.strongDistractor!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
            ),
          ),
        if (_eliminationBullets(q.eliminationLogicJson).isNotEmpty)
          _CollapsibleBlock(
            title: l10n.practiceTestCollapsibleElimination,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _eliminationBullets(q.eliminationLogicJson)
                  .map(
                    (line) => Padding(
                      padding: EdgeInsets.only(bottom: context.hp(0.8)),
                      child: Text(
                        '• $line',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.45,
                            ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        if (_formatStatementAnalysis(q.statementAnalysisJson) != null)
          _CollapsibleBlock(
            title: l10n.practiceTestCollapsibleStatement,
            child: Text(
              _formatStatementAnalysis(q.statementAnalysisJson)!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.45,
                  ),
            ),
          ),
      ],
    );
  }

  static List<String> _eliminationBullets(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    try {
      final d = jsonDecode(raw);
      if (d is List) return d.map((e) => '$e').toList();
    } catch (_) {}
    return [];
  }

  static String? _formatStatementAnalysis(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final d = jsonDecode(raw);
      if (d is! List) return raw;
      final b = StringBuffer();
      for (final x in d) {
        if (x is Map) {
          b.writeln('• ${x['statement']}');
          b.writeln('  ${x['verdict']}: ${x['reason']}\n');
        }
      }
      final s = b.toString().trim();
      return s.isEmpty ? null : s;
    } catch (_) {
      return raw;
    }
  }
}

class _CollapsibleBlock extends StatelessWidget {
  const _CollapsibleBlock({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.hp(1.2)),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.4),
        child: ExpansionTile(
          initiallyExpanded: false,
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          childrenPadding: EdgeInsets.fromLTRB(
            context.wp(3),
            0,
            context.wp(3),
            context.hp(1.5),
          ),
          children: [child],
        ),
      ),
    );
  }
}
