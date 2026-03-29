import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upsc_wars_new/core/constants/app_colors.dart';
import 'package:upsc_wars_new/core/constants/app_durations.dart';
import 'package:upsc_wars_new/core/constants/app_sizes.dart';
import 'package:upsc_wars_new/core/providers/database_provider.dart';
import 'package:upsc_wars_new/core/providers/shared_preferences_provider.dart';
import 'package:upsc_wars_new/core/router/app_router.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/mcq_seed/domain/entities/mcq_seed_progress.dart';
import 'package:upsc_wars_new/features/mcq_seed/presentation/providers/mcq_seed_controller.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final seedState = ref.watch(mcqSeedControllerProvider);
    final retryCount = useState(0);

    useEffect(() {
      var cancelled = false;

      Future<void> bootstrap() async {
        final started = DateTime.now();
        final db = await ref.read(appDatabaseProvider.future);
        final prefs = await ref.read(sharedPreferencesProvider.future);
        if (cancelled || !context.mounted) return;

        final result = await ref
            .read(mcqSeedControllerProvider.notifier)
            .run(db, prefs);

        final elapsed = DateTime.now().difference(started);
        final remaining = AppDurations.splashMinimum - elapsed;
        if (remaining > Duration.zero) {
          await Future<void>.delayed(remaining);
        }

        if (cancelled || !context.mounted) return;

        result.fold(
          (_) {},
          (_) => context.goNamed(AppRoute.home.name),
        );
      }

      bootstrap();
      return () {
        cancelled = true;
      };
    }, [retryCount.value]);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school_rounded,
                size: AppSizes.iconXl * 2,
                color: Colors.white,
              ),
              SizedBox(height: context.hp(2)),
              Text(
                'UPSC Wars',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
              ),
              SizedBox(height: context.hp(1)),
              Text(
                'Master the exam',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withAlpha(180),
                      letterSpacing: 0.5,
                    ),
              ),
              if (seedState.isWorking && seedState.progress != null) ...[
                SizedBox(height: context.hp(4)),
                _SeedProgressSection(
                  progress: seedState.progress!,
                  l10n: l10n,
                ),
              ],
              if (!seedState.isWorking && seedState.failure != null) ...[
                SizedBox(height: context.hp(3)),
                Text(
                  l10n.mcqSeedFailed,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withAlpha(220),
                      ),
                ),
                SizedBox(height: context.hp(2)),
                TextButton(
                  onPressed: () => retryCount.value++,
                  child: Text(
                    l10n.mcqSeedRetry,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.sp(16),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SeedProgressSection extends StatelessWidget {
  const _SeedProgressSection({
    required this.progress,
    required this.l10n,
  });

  final McqSeedProgress progress;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final overallPct = (progress.overallFraction * 100).clamp(0, 100).round();
    final subjectPct =
        (progress.subjectFraction * 100).clamp(0, 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.mcqSeedOverallProgress(overallPct),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withAlpha(230),
                fontSize: context.sp(14),
              ),
        ),
        SizedBox(height: context.hp(0.8)),
        ClipRRect(
          borderRadius: BorderRadius.circular(1),
          child: LinearProgressIndicator(
            value: progress.overallFraction.clamp(0, 1),
            backgroundColor: Colors.white24,
            color: Colors.white,
            minHeight: 1,
          ),
        ),
        SizedBox(height: context.hp(2)),
        Text(
          l10n.mcqSeedSubjectProgress(
            progress.currentSubjectLabel,
            subjectPct,
          ),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withAlpha(230),
                fontSize: context.sp(14),
              ),
        ),
        SizedBox(height: context.hp(0.8)),
        ClipRRect(
          borderRadius: BorderRadius.circular(1),
          child: LinearProgressIndicator(
            value: progress.subjectFraction.clamp(0, 1),
            backgroundColor: Colors.white24,
            color: Colors.white,
            minHeight: 1,
          ),
        ),
      ],
    );
  }
}
