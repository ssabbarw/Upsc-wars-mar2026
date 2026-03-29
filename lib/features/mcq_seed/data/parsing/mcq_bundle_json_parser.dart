import 'dart:convert';

/// Parses one asset file (JSON array of questions) off the UI isolate.
///
/// Must remain a top-level function so it can be passed to [compute].
Map<String, dynamic> parseMcqBundleJson(String raw) {
  final decoded = jsonDecode(raw) as List<dynamic>;
  final mcqRows = <Map<String, dynamic>>[];
  final contentRows = <Map<String, dynamic>>[];
  final tableRows = <Map<String, dynamic>>[];

  for (final Object? item in decoded) {
    if (item is! Map<String, dynamic>) continue;
    final meta = item['meta'] as Map<String, dynamic>?;
    final solution = item['solution'] as Map<String, dynamic>?;
    final fp = item['formatted_presentation'] as Map<String, dynamic>?;
    if (meta == null || solution == null || fp == null) continue;

    final overall = meta['overall_que_no'];
    final subjectNo = meta['subject_que_no'];
    if (overall is! int || subjectNo is! int) continue;

    final concepts = meta['concepts_used'];
    final conceptsJson =
        jsonEncode(concepts is List<dynamic> ? concepts : <dynamic>[]);

    final hasTable = fp['has_table'] == true;
    final correct = solution['correct_option'];
    final correctStr = correct is String ? correct : '$correct';

    mcqRows.add(<String, dynamic>{
      'overall_que_no': overall,
      'subject_que_no': subjectNo,
      'subject': '${meta['subject'] ?? ''}',
      'topic': '${meta['topic'] ?? ''}',
      'sub_topic': meta['sub_topic'],
      'question_type': '${solution['question_type'] ?? ''}',
      'trap_type': solution['trap_type'],
      'concepts_used': conceptsJson,
      'concept_anchor': solution['concept_anchor'],
      'has_table': hasTable ? 1 : 0,
      'user_attempt': null,
      'correct_option': correctStr,
      'bookmarked': 0,
    });

    final displayText = fp['display_text'];
    final tableData = fp['table_data'] as Map<String, dynamic>?;
    var questionText = '';
    if (displayText is String && displayText.isNotEmpty) {
      questionText = displayText;
    } else if (tableData != null) {
      final footer = tableData['footer_text'];
      if (footer is String) questionText = footer;
    }

    final elim = solution['elimination_logic'];
    final elimJson = elim == null ? null : jsonEncode(elim);

    final stmt = solution['statement_analysis'];
    final stmtJson = stmt == null ? null : jsonEncode(stmt);

    contentRows.add(<String, dynamic>{
      'overall_que_no': overall,
      'subject_que_no': subjectNo,
      'question_text': questionText,
      'display_text': displayText is String ? displayText : null,
      'final_explanation': solution['final_explanation'],
      'upsc_trap_explanation': solution['upsc_trap_explanation'],
      'strong_distractor': solution['strong_distractor'],
      'elimination_logic': elimJson,
      'statement_analysis': stmtJson,
    });

    if (hasTable && tableData != null) {
      final cols = tableData['columns'];
      final rows = tableData['rows'];
      tableRows.add(<String, dynamic>{
        'overall_que_no': overall,
        'subject_que_no': subjectNo,
        'header_text': tableData['header_text'],
        'footer_text': tableData['footer_text'],
        'rows': jsonEncode(rows is List<dynamic> ? rows : <dynamic>[]),
        'columns': jsonEncode(cols is List<dynamic> ? cols : <dynamic>[]),
      });
    }
  }

  return <String, dynamic>{
    'mcq': mcqRows,
    'content': contentRows,
    'table': tableRows,
  };
}

/// Parses several JSON bundle files in a single isolate trip (reduces [compute] overhead).
///
/// Must remain a top-level function so it can be passed to [compute].
Map<String, dynamic> parseMcqBundleJsonBatch(List<String> rawStrings) {
  final mergedMcq = <Map<String, dynamic>>[];
  final mergedContent = <Map<String, dynamic>>[];
  final mergedTable = <Map<String, dynamic>>[];
  for (final raw in rawStrings) {
    final one = parseMcqBundleJson(raw);
    mergedMcq.addAll((one['mcq'] as List<dynamic>).cast<Map<String, dynamic>>());
    mergedContent
        .addAll((one['content'] as List<dynamic>).cast<Map<String, dynamic>>());
    mergedTable
        .addAll((one['table'] as List<dynamic>).cast<Map<String, dynamic>>());
  }
  return <String, dynamic>{
    'mcq': mergedMcq,
    'content': mergedContent,
    'table': mergedTable,
  };
}
