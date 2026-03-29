import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_wars_new/core/constants/app_colors.dart';
import 'package:upsc_wars_new/core/router/app_router.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_test_outcome.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Post-submit summary with score breakdown and entry to explanations.
class PracticeTestResultsPage extends StatelessWidget {
  /// Creates the results view; [outcome] is normally passed via [GoRouterState.extra].
  const PracticeTestResultsPage({super.key, required this.outcome});

  final PracticeTestOutcome? outcome;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final o = outcome;

    if (o == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.practiceTestResultsMissing)),
      );
    }

    final scheme = Theme.of(context).colorScheme;
    final typeEntries = o.accuracyByQuestionType.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            title: Text(l10n.practiceTestResultsTitle),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              context.wp(4),
              context.hp(1),
              context.wp(4),
              context.hp(3),
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: context.hp(3),
                    horizontal: context.wp(5),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        scheme.primary.withValues(alpha: 0.15),
                        scheme.secondary.withValues(alpha: 0.12),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(context.wp(4)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${o.accuracyPercent}%',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: scheme.primary,
                              fontSize: context.sp(40),
                            ),
                      ),
                      SizedBox(height: context.hp(0.5)),
                      Text(
                        l10n.practiceTestStatAccuracy,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.hp(2.5)),
                _StatRow(
                  icon: Icons.quiz_outlined,
                  label: l10n.practiceTestStatTotal,
                  value: '${o.totalQuestions}',
                  color: scheme.onSurfaceVariant,
                ),
                _StatRow(
                  icon: Icons.check_circle_outline,
                  label: l10n.practiceTestStatCorrect,
                  value: '${o.correctCount}',
                  color: AppColors.success,
                ),
                _StatRow(
                  icon: Icons.cancel_outlined,
                  label: l10n.practiceTestStatIncorrect,
                  value: '${o.incorrectCount}',
                  color: scheme.error,
                ),
                _StatRow(
                  icon: Icons.skip_next_outlined,
                  label: l10n.practiceTestStatSkipped,
                  value: '${o.skippedCount}',
                  color: scheme.tertiary,
                ),
                _StatRow(
                  icon: Icons.schedule_outlined,
                  label: l10n.practiceTestStatTime,
                  value: _fmtDuration(o.timeTaken),
                  color: scheme.onSurfaceVariant,
                ),
                if (typeEntries.isNotEmpty) ...[
                  SizedBox(height: context.hp(2.5)),
                  Text(
                    l10n.practiceTestTypeBreakdown,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(height: context.hp(1)),
                  ...typeEntries.map(
                    (e) => Padding(
                      padding: EdgeInsets.only(bottom: context.hp(0.8)),
                      child: ListTile(
                        tileColor:
                            scheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(context.wp(2)),
                        ),
                        title: Text(
                          l10n.practiceTestTypeRow(e.key, e.value),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(height: context.hp(3)),
                FilledButton.icon(
                  onPressed: () {
                    context.pushNamed(
                      AppRoute.practiceTestReview.name,
                      extra: o,
                    );
                  },
                  icon: const Icon(Icons.menu_book_outlined),
                  label: Text(l10n.practiceTestReviewExplanations),
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: context.hp(1.6),
                    ),
                  ),
                ),
                SizedBox(height: context.hp(1.2)),
                OutlinedButton(
                  onPressed: () {
                    context.goNamed(
                      AppRoute.subjectTests.name,
                      pathParameters: {'subjectId': o.subjectId},
                    );
                  },
                  child: Text(l10n.practiceTestBackHome),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  static String _fmtDuration(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '${m}m ${s.toString().padLeft(2, '0')}s';
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.hp(1)),
      child: ListTile(
        leading: Icon(icon, color: color, size: context.sp(26)),
        title: Text(label),
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        tileColor: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.wp(2)),
        ),
      ),
    );
  }
}
