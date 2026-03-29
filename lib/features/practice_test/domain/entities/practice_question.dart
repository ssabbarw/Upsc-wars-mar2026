import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_table_data.dart';

/// One question loaded for an in-progress or completed practice test.
class PracticeQuestion {
  /// Creates a practice question snapshot from local DB rows.
  const PracticeQuestion({
    required this.overallQueNo,
    required this.subjectQueNo,
    required this.questionType,
    required this.hasTable,
    required this.correctOption,
    required this.bookmarked,
    required this.questionText,
    this.displayText,
    this.finalExplanation,
    this.upscTrapExplanation,
    this.strongDistractor,
    this.eliminationLogicJson,
    this.statementAnalysisJson,
    this.trapType,
    this.conceptAnchor,
    this.table,
  });

  final int overallQueNo;
  final int subjectQueNo;
  final String questionType;
  final bool hasTable;

  /// Lowercase `a`–`d`.
  final String correctOption;
  final bool bookmarked;

  /// Fallback stem text from content row.
  final String questionText;

  /// Full presentation text when not using a structured table.
  final String? displayText;

  final String? finalExplanation;
  final String? upscTrapExplanation;
  final String? strongDistractor;
  final String? eliminationLogicJson;
  final String? statementAnalysisJson;

  /// From `solution.trap_type` in bundled JSON (`mcq_meta_data.trap_type`).
  final String? trapType;

  /// From `solution.concept_anchor` (`mcq_meta_data.concept_anchor`).
  final String? conceptAnchor;

  final PracticeTableData? table;
}
