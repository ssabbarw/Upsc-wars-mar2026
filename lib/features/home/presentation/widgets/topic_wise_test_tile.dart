import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_wars_new/core/constants/app_sizes.dart';
import 'package:upsc_wars_new/core/router/app_router.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Full-width banner tile that navigates to the topic-wise tests flow.
///
/// Usage:
/// ```dart
/// const TopicWiseTestTile()
/// ```
class TopicWiseTestTile extends StatelessWidget {
  const TopicWiseTestTile({super.key});

  static const _color = Color(0xFF4527A0); // Deep Purple

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: Material(
          color: _color,
          child: InkWell(
            onTap: () {
              context.pushNamed(AppRoute.topicWiseBrowse.name);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.lg,
                vertical: AppSizes.lg,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.topicWiseTests,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: AppSizes.xs),
                        Text(
                          l10n.chapterBasedTests,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: context.wp(11),
                    height: context.wp(11),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: _color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
