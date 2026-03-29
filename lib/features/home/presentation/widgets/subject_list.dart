import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_wars_new/core/constants/app_sizes.dart';
import 'package:upsc_wars_new/core/router/app_router.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/home/data/datasources/subjects_datasource.dart';
import 'package:upsc_wars_new/features/home/domain/entities/subject.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Horizontally scrollable row of subject tiles.
///
/// Drop anywhere with:
/// ```dart
/// const SubjectList()
/// ```
class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = SubjectsDataSource.all;
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      height: context.hp(19),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        itemCount: subjects.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSizes.sm),
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return _SubjectTile(
            subject: subject,
            l10n: l10n,
            onOpenTests: () {
              context.pushNamed(
                AppRoute.subjectTests.name,
                pathParameters: {'subjectId': subject.id},
              );
            },
          );
        },
      ),
    );
  }
}

class _SubjectTile extends StatelessWidget {
  const _SubjectTile({
    required this.subject,
    required this.l10n,
    required this.onOpenTests,
  });

  final Subject subject;
  final AppLocalizations l10n;
  final VoidCallback onOpenTests;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgAlpha = isDark ? 45 : 28;
    final bg = subject.color.withAlpha(bgAlpha);

    return SizedBox(
      width: context.wp(30),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onOpenTests,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: context.wp(25),
                height: context.wp(25),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: Icon(
                  subject.icon,
                  color: subject.color,
                  size: AppSizes.iconXl,
                ),
              ),
              const SizedBox(height: AppSizes.xs),
              Text(
                subject.name(l10n),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.2,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
