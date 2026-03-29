import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upsc_wars_new/core/constants/app_constants.dart';
import 'package:upsc_wars_new/core/constants/app_sizes.dart';
import 'package:upsc_wars_new/core/widgets/countdown_timer.dart';
import 'package:upsc_wars_new/features/home/presentation/widgets/pyq_list.dart';
import 'package:upsc_wars_new/features/home/presentation/widgets/subject_list.dart';
import 'package:upsc_wars_new/features/home/presentation/widgets/topic_wise_test_tile.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
      ),
      body: ListView(
        children: [
          // ── Countdown ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.md,
              AppSizes.md,
              AppSizes.md,
              0,
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.lg),
                child: CountdownTimer(
                  targetDate: AppConstants.upscPrelimsDate,
                  label: 'Left Till Prelims',
                ),
              ),
            ),
          ),

          // ── Topic-Wise Tests ─────────────────────────────────────────────
          const Padding(
            padding: EdgeInsets.only(top: AppSizes.lg),
            child: TopicWiseTestTile(),
          ),

          // ── Subjects ─────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.md,
              AppSizes.lg,
              AppSizes.md,
              AppSizes.sm,
            ),
            child: Text(
              l10n.subjects,
              style: textTheme.titleMedium,
            ),
          ),
          const SubjectList(),

          // ── Previous Year Questions ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.md,
              AppSizes.lg,
              AppSizes.md,
              AppSizes.sm,
            ),
            child: Text(
              l10n.previousYearQuestions,
              style: textTheme.titleMedium,
            ),
          ),
          const PYQList(),

          const SizedBox(height: AppSizes.md),
        ],
      ),
    );
  }
}
