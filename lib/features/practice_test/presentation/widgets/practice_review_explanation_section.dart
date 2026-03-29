import 'package:flutter/material.dart';
import 'package:upsc_wars_new/core/constants/app_colors.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_question.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_test_outcome.dart';
import 'package:upsc_wars_new/features/practice_test/presentation/utils/practice_review_explanation_parse.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// Verdict strip, explanation card (with optional value addition), and deep-dive tabs.
class PracticeReviewExplanationSection extends StatefulWidget {
  /// Creates the post-question explanation block for review mode.
  const PracticeReviewExplanationSection({
    super.key,
    required this.item,
    required this.l10n,
  });

  final PracticeQuestionResultItem item;
  final AppLocalizations l10n;

  @override
  State<PracticeReviewExplanationSection> createState() =>
      _PracticeReviewExplanationSectionState();
}

class _PracticeReviewExplanationSectionState
    extends State<PracticeReviewExplanationSection>
    with SingleTickerProviderStateMixin {
  bool _valueAdditionVisible = false;
  late TabController _deepTabController;

  @override
  void initState() {
    super.initState();
    _deepTabController = _createDeepTabController();
    _deepTabController.addListener(_onDeepTabTick);
  }

  @override
  void didUpdateWidget(covariant PracticeReviewExplanationSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.question.statementAnalysisJson !=
            widget.item.question.statementAnalysisJson ||
        oldWidget.item.question.overallQueNo !=
            widget.item.question.overallQueNo) {
      _deepTabController.removeListener(_onDeepTabTick);
      _deepTabController.dispose();
      _deepTabController = _createDeepTabController();
      _deepTabController.addListener(_onDeepTabTick);
    }
  }

  TabController _createDeepTabController() {
    final hasStatements = parseStatementAnalysisJson(
      widget.item.question.statementAnalysisJson,
    ).isNotEmpty;
    final length = hasStatements ? 3 : 2;
    return TabController(length: length, vsync: this);
  }

  void _onDeepTabTick() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _deepTabController.removeListener(_onDeepTabTick);
    _deepTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final item = widget.item;
    final q = item.question;
    final scheme = Theme.of(context).colorScheme;

    final optionTexts = parseOptionLetterToText(q.displayText, q.questionText);
    final correctLower = q.correctOption.toLowerCase();
    final correctLetterUpper = correctLower.toUpperCase();
    final correctBody = optionTexts[correctLower] ?? '';

    final explanationParts = splitFinalExplanation(q.finalExplanation);
    final statements = parseStatementAnalysisJson(q.statementAnalysisJson);
    final eliminationLines = decodeEliminationLines(q.eliminationLogicJson)
        .map(parseEliminationRow)
        .toList();

    final hasStatements = statements.isNotEmpty;
    final tabLabels = <String>[
      if (hasStatements) l10n.practiceTestReviewTabStatements,
      l10n.practiceTestReviewTabElimination,
      l10n.practiceTestReviewTabTrap,
    ];

    final tabController = _deepTabController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _VerdictStrip(
          item: item,
          l10n: l10n,
          correctLetterUpper: correctLetterUpper,
          correctOptionBody: correctBody,
          strongDistractorText: q.strongDistractor,
          conceptAnchor: q.conceptAnchor,
        ),
        SizedBox(height: context.hp(2)),
        _FlatCard(
          borderColor: scheme.outline.withValues(alpha: 0.45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (explanationParts.mainProse.isNotEmpty)
                Text(
                  explanationParts.mainProse,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.55,
                        fontSize: context.sp(15),
                      ),
                )
              else
                Text(
                  '—',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
              if (explanationParts.valueAdditionBullets.isNotEmpty) ...[
                SizedBox(height: context.hp(1.2)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => setState(
                      () => _valueAdditionVisible = !_valueAdditionVisible,
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: scheme.onSurfaceVariant,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      _valueAdditionVisible
                          ? l10n.practiceTestReviewValueAdditionToggleHide
                          : l10n.practiceTestReviewValueAdditionToggleShow,
                      style: TextStyle(
                        fontSize: context.sp(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (_valueAdditionVisible)
                  ...explanationParts.valueAdditionBullets.map(
                    (bullet) => Padding(
                      padding: EdgeInsets.only(
                        top: context.hp(0.6),
                        left: context.wp(1),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(
                              fontSize: context.sp(15),
                              color: AppColors.warning,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              bullet,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    height: 1.5,
                                    fontSize: context.sp(14),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
        SizedBox(height: context.hp(2)),
        Text(
          l10n.practiceTestReviewDeepDiveTitle,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: context.sp(15),
                fontWeight: FontWeight.w700,
              ),
        ),
        SizedBox(height: context.hp(0.8)),
        _FlatCard(
          borderColor: scheme.outline.withValues(alpha: 0.45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TabBar(
                controller: tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: scheme.primary,
                dividerColor: Colors.transparent,
                labelColor: scheme.primary,
                unselectedLabelColor: scheme.onSurfaceVariant,
                labelStyle: TextStyle(
                  fontSize: context.sp(14),
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: context.sp(14),
                  fontWeight: FontWeight.w500,
                ),
                tabs: tabLabels.map((t) => Tab(text: t)).toList(),
              ),
              Divider(height: 1, color: scheme.outline.withValues(alpha: 0.35)),
              Padding(
                padding: EdgeInsets.only(top: context.hp(1.2)),
                child: _DeepTabBody(
                  tabIndex: tabController.index,
                  hasStatementsTab: hasStatements,
                  statements: statements,
                  eliminationRows: eliminationLines,
                  question: q,
                  l10n: l10n,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VerdictStrip extends StatelessWidget {
  const _VerdictStrip({
    required this.item,
    required this.l10n,
    required this.correctLetterUpper,
    required this.correctOptionBody,
    required this.strongDistractorText,
    required this.conceptAnchor,
  });

  final PracticeQuestionResultItem item;
  final AppLocalizations l10n;
  final String correctLetterUpper;
  final String correctOptionBody;
  final String? strongDistractorText;
  final String? conceptAnchor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final userLower = item.userAnswer?.toLowerCase();
    final isCorrect = item.isCorrect;
    final isSkipped = item.wasSkipped;

    final bool positive = isCorrect;
    final Color accent = positive ? AppColors.success : scheme.error;
    final Color bg = positive
        ? AppColors.success.withValues(alpha: 0.12)
        : scheme.error.withValues(alpha: 0.12);

    String headline;
    if (isSkipped) {
      headline = l10n.practiceTestReviewVerdictSkipped(correctLetterUpper);
    } else if (isCorrect) {
      headline = l10n.practiceTestReviewVerdictCorrect(
        userLower?.toUpperCase() ?? correctLetterUpper,
      );
    } else {
      headline =
          l10n.practiceTestReviewVerdictIncorrect(correctLetterUpper);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(context.wp(4)),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(context.wp(2)),
            border: Border.all(color: accent.withValues(alpha: 0.65)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                headline,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: context.sp(15),
                      fontWeight: FontWeight.w800,
                      color: accent,
                      height: 1.25,
                    ),
              ),
              SizedBox(height: context.hp(1)),
              Text(
                l10n.practiceTestReviewCorrectOptionLine(
                  correctLetterUpper,
                  correctOptionBody.isNotEmpty
                      ? correctOptionBody
                      : l10n.practiceTestOption(correctLetterUpper),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: context.sp(14),
                      height: 1.45,
                      color: scheme.onSurface,
                    ),
              ),
            ],
          ),
        ),
        if (strongDistractorText != null &&
            strongDistractorText!.trim().isNotEmpty) ...[
          SizedBox(height: context.hp(1.2)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.wp(3.5)),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(context.wp(2)),
              border: Border.all(
                color: AppColors.warning.withValues(alpha: 0.55),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.practiceTestReviewStrongDistractorHeading,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: context.sp(12),
                        fontWeight: FontWeight.w800,
                        color: scheme.onSurface,
                        letterSpacing: 0.3,
                      ),
                ),
                SizedBox(height: context.hp(0.6)),
                Text(
                  strongDistractorText!.trim(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: context.sp(14),
                        height: 1.5,
                        color: scheme.onSurface,
                      ),
                ),
              ],
            ),
          ),
        ],
        if (conceptAnchor != null && conceptAnchor!.trim().isNotEmpty) ...[
          SizedBox(height: context.hp(1)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: context.wp(3.5),
              vertical: context.hp(1),
            ),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(context.wp(2)),
              border: Border.all(
                color: scheme.outline,
                width: 1,
              ),
            ),
            child: Text(
              conceptAnchor!.trim(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: context.sp(13),
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                    color: scheme.onSurface,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}

class _FlatCard extends StatelessWidget {
  const _FlatCard({
    required this.borderColor,
    required this.child,
  });

  final Color borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.wp(4)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.wp(2)),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}

class _DeepTabBody extends StatelessWidget {
  const _DeepTabBody({
    required this.tabIndex,
    required this.hasStatementsTab,
    required this.statements,
    required this.eliminationRows,
    required this.question,
    required this.l10n,
  });

  final int tabIndex;
  final bool hasStatementsTab;
  final List<StatementAnalysisEntry> statements;
  final List<EliminationRowModel> eliminationRows;
  final PracticeQuestion question;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    int offset = 0;
    if (hasStatementsTab) {
      if (tabIndex == 0) {
        return _StatementsPanel(entries: statements, l10n: l10n);
      }
      offset = 1;
    }
    if (tabIndex == offset) {
      if (eliminationRows.isEmpty) {
        return Text(
          l10n.practiceTestReviewEmptySection,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                fontSize: context.sp(14),
              ),
        );
      }
      return _EliminationPanel(rows: eliminationRows);
    }
    return _TrapPanel(question: question, l10n: l10n);
  }
}

class _StatementsPanel extends StatelessWidget {
  const _StatementsPanel({
    required this.entries,
    required this.l10n,
  });

  final List<StatementAnalysisEntry> entries;
  final AppLocalizations l10n;

  bool _verdictPositive(String verdict) {
    final v = verdict.toLowerCase().trim();
    if (v.contains('incorrect') || v.contains('not correct')) {
      return false;
    }
    return v.contains('correct');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (entries.isEmpty) {
      return Text(
        l10n.practiceTestReviewEmptySection,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              fontSize: context.sp(14),
            ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: entries.map((e) {
        final ok = _verdictPositive(e.verdict);
        final badgeColor = ok ? AppColors.success : scheme.error;
        final badgeBg = ok
            ? AppColors.success.withValues(alpha: 0.14)
            : scheme.error.withValues(alpha: 0.12);
        return Padding(
          padding: EdgeInsets.only(bottom: context.hp(1.4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                e.statement,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: context.sp(14),
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: context.hp(0.6)),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.wp(2.5),
                    vertical: context.hp(0.35),
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(context.wp(1)),
                    border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    e.verdict,
                    style: TextStyle(
                      fontSize: context.sp(12),
                      fontWeight: FontWeight.w800,
                      color: badgeColor,
                    ),
                  ),
                ),
              ),
              if (e.reason.isNotEmpty) ...[
                SizedBox(height: context.hp(0.5)),
                Text(
                  e.reason,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: context.sp(13),
                        height: 1.45,
                        color: scheme.onSurfaceVariant,
                      ),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _EliminationPanel extends StatelessWidget {
  const _EliminationPanel({required this.rows});

  final List<EliminationRowModel> rows;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows.map((row) {
        Color dotFill;
        Color dotBorder;
        Color? letterColor;
        if (row.optionLetter != null && row.isConfirmedOption == true) {
          dotFill = AppColors.success.withValues(alpha: 0.2);
          dotBorder = AppColors.success;
          letterColor = AppColors.success;
        } else if (row.optionLetter != null && row.isConfirmedOption == false) {
          dotFill = scheme.error.withValues(alpha: 0.12);
          dotBorder = scheme.error;
          letterColor = scheme.error;
        } else {
          dotFill = scheme.surfaceContainerHighest.withValues(alpha: 0.5);
          dotBorder = scheme.outline.withValues(alpha: 0.45);
          letterColor = scheme.onSurfaceVariant;
        }

        final letter = row.optionLetter?.toUpperCase() ?? '·';

        return Padding(
          padding: EdgeInsets.only(bottom: context.hp(1.1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.sp(26),
                height: context.sp(26),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotFill,
                  border: Border.all(color: dotBorder, width: 1.5),
                ),
                child: Text(
                  letter,
                  style: TextStyle(
                    fontSize: context.sp(12),
                    fontWeight: FontWeight.w800,
                    color: letterColor,
                  ),
                ),
              ),
              SizedBox(width: context.wp(3)),
              Expanded(
                child: Text(
                  row.text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: context.sp(14),
                        height: 1.45,
                      ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _TrapPanel extends StatelessWidget {
  const _TrapPanel({
    required this.question,
    required this.l10n,
  });

  final PracticeQuestion question;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final trapType = question.trapType;
    final why = question.upscTrapExplanation;
    final trapPillText =
        trapType != null && trapType.trim().isNotEmpty ? trapType.trim() : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (trapPillText != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.wp(2.5),
                vertical: context.hp(0.4),
              ),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(context.wp(5)),
                border: Border.all(
                  color: AppColors.warning.withValues(alpha: 0.45),
                ),
              ),
              child: Text(
                trapPillText,
                style: TextStyle(
                  fontSize: context.sp(12),
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ),
        if (trapPillText != null) SizedBox(height: context.hp(1.2)),
        if (why != null && why.trim().isNotEmpty) ...[
          Text(
            l10n.practiceTestReviewWhyWrongHeading,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: context.sp(12),
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurfaceVariant,
                  letterSpacing: 0.4,
                ),
          ),
          SizedBox(height: context.hp(0.5)),
          Text(
            why.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: context.sp(14),
                  height: 1.5,
                ),
          ),
        ],
        if (trapPillText == null && (why == null || why.trim().isEmpty))
          Text(
            l10n.practiceTestReviewEmptySection,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontSize: context.sp(14),
                ),
          ),
      ],
    );
  }
}
