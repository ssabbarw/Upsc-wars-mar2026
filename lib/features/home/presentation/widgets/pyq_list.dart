import 'package:flutter/material.dart';
import 'package:upsc_wars_new/core/constants/app_sizes.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/home/data/datasources/pyq_years_datasource.dart';
import 'package:upsc_wars_new/features/home/domain/entities/pyq_year.dart';

/// Horizontally scrollable row of Previous Year Question year cards.
///
/// Drop anywhere with:
/// ```dart
/// const PYQList()
/// ```
class PYQList extends StatelessWidget {
  const PYQList({super.key});

  @override
  Widget build(BuildContext context) {
    final years = PYQYearsDataSource.all;

    return SizedBox(
      height: context.hp(22),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        itemCount: years.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSizes.sm),
        itemBuilder: (context, index) => _PYQCard(year: years[index]),
      ),
    );
  }
}

class _PYQCard extends StatelessWidget {
  const _PYQCard({required this.year});

  final PYQYear year;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: context.wp(38),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  year.color,
                  year.color.withAlpha(180),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: year.color.withAlpha(80),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  year.year.toString(),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                Container(
                  width: context.wp(8),
                  height: context.wp(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(220),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: year.color,
                    size: AppSizes.iconSm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
