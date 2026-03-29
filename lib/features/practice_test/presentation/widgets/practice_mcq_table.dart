import 'package:flutter/material.dart';
import 'package:upsc_wars_new/core/constants/app_sizes.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_table_data.dart';

/// Renders header → scrollable table → footer for table-style MCQs.
class PracticeMcqTable extends StatelessWidget {
  /// Creates a styled table block for the question stem.
  const PracticeMcqTable({super.key, required this.data});

  final PracticeTableData data;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final outlineColor = scheme.outlineVariant.withValues(alpha: 0.6);
    final boxBorder = Border.all(color: outlineColor);
    final cellSide = BorderSide(color: outlineColor);

    if (data.columns.isEmpty) {
      return Text(
        data.footerText ?? data.headerText ?? '',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.45),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (data.headerText != null && data.headerText!.trim().isNotEmpty) ...[
          Text(
            data.headerText!,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: context.hp(1)),
        ],
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            border: boxBorder,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                    ),
                    child: DataTable(
                      headingRowHeight: context.hp(3.6),
                      dataRowMinHeight: context.hp(3),
                      dataRowMaxHeight: context.hp(11),
                      horizontalMargin: context.wp(1),
                      columnSpacing: context.wp(2),
                      dividerThickness: 1,
                      headingTextStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                            height: 1.25,
                            fontSize: context.sp(13),
                          ),
                      dataTextStyle: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(height: 1.3, fontSize: context.sp(13)),
                      border: TableBorder(
                        horizontalInside: cellSide,
                        verticalInside: cellSide,
                        top: cellSide,
                        bottom: cellSide,
                        left: cellSide,
                        right: cellSide,
                      ),
                      columns: [
                        for (final c in data.columns)
                          DataColumn(
                            label: Text(
                              c,
                              softWrap: true,
                              maxLines: 4,
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: context.sp(13),
                                    height: 1.25,
                                  ),
                            ),
                          ),
                      ],
                      rows: [
                        for (final row in data.rows)
                          DataRow(
                            cells: [
                              for (var i = 0; i < data.columns.length; i++)
                                DataCell(
                                  Text(
                                    i < row.length ? row[i] : '',
                                    softWrap: true,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          height: 1.3,
                                          fontSize: context.sp(13),
                                        ),
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (data.footerText != null && data.footerText!.trim().isNotEmpty) ...[
          SizedBox(height: context.hp(1)),
          Text(
            data.footerText!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.45,
                ),
          ),
        ],
      ],
    );
  }
}
