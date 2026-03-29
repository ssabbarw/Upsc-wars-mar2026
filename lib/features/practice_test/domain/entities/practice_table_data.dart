/// Parsed table payload for an MCQ that uses `mcqs_with_table_en`.
class PracticeTableData {
  /// Creates table data for the question stem.
  const PracticeTableData({
    this.headerText,
    this.footerText,
    required this.columns,
    required this.rows,
  });

  /// Optional heading above the grid.
  final String? headerText;

  /// Optional text below the grid (often includes the actual options).
  final String? footerText;

  /// Column headings.
  final List<String> columns;

  /// Body rows (each row has one cell per column).
  final List<List<String>> rows;
}
