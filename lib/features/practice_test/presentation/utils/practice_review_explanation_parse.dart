import 'dart:convert';

/// Pure helpers to split explanations and decode review-only JSON fields.
///
/// Kept free of Flutter imports for reuse and tests.

/// Prose before "Value Addition:" plus optional bullet lines after it.
class FinalExplanationParts {
  /// Creates split final explanation content.
  const FinalExplanationParts({
    required this.mainProse,
    required this.valueAdditionBullets,
  });

  /// Text shown in the main explanation card (excluding value-addition block).
  final String mainProse;

  /// Lines extracted after the `Value Addition:` header.
  final List<String> valueAdditionBullets;
}

/// One row from `statement_analysis` JSON.
class StatementAnalysisEntry {
  /// Creates a parsed statement row.
  const StatementAnalysisEntry({
    required this.statement,
    required this.verdict,
    required this.reason,
  });

  final String statement;
  final String verdict;
  final String reason;
}

/// Parsed elimination row for colouring (confirm vs eliminate vs neutral).
class EliminationRowModel {
  /// Creates a model for one elimination_logic string.
  const EliminationRowModel({
    required this.text,
    this.optionLetter,
    this.isConfirmedOption,
  });

  final String text;

  /// Lowercase `a`–`d` when parsed from the line, else `null`.
  final String? optionLetter;

  /// `true` = confirm line, `false` = eliminate line, `null` = neutral narrative.
  final bool? isConfirmedOption;
}

/// Extracts `(a)…(d)` option texts from MCQ stem (`display_text` / `question_text`).
Map<String, String> parseOptionLetterToText(String? displayText, String questionText) {
  final source = (displayText != null && displayText.trim().isNotEmpty)
      ? displayText
      : questionText;
  final map = <String, String>{};
  final linePattern = RegExp(r'^\(([a-dA-D])\)\s*(.+)$');
  for (final rawLine in source.split('\n')) {
    final line = rawLine.trim();
    final m = linePattern.firstMatch(line);
    if (m != null) {
      map[m.group(1)!.toLowerCase()] = m.group(2)!.trim();
    }
  }
  return map;
}

/// Splits [raw] into main prose and value-addition bullets (after `Value Addition:`).
FinalExplanationParts splitFinalExplanation(String? raw) {
  if (raw == null || raw.trim().isEmpty) {
    return const FinalExplanationParts(mainProse: '', valueAdditionBullets: []);
  }
  final full = raw.trim();
  final match = RegExp(
    r'\n+\s*Value Addition\s*:\s*',
    caseSensitive: false,
  ).firstMatch(full);

  if (match == null) {
    return FinalExplanationParts(mainProse: full, valueAdditionBullets: []);
  }

  final main = full.substring(0, match.start).trim();
  final tail = full.substring(match.end).trim();
  final bullets = <String>[];
  for (final line in tail.split('\n')) {
    final t = line.trim();
    if (t.isEmpty) continue;
    final stripped = t.replaceFirst(RegExp(r'^[•\-\*·]\s*'), '').trim();
    if (stripped.isNotEmpty) {
      bullets.add(stripped);
    }
  }

  return FinalExplanationParts(mainProse: main, valueAdditionBullets: bullets);
}

/// Decodes `statement_analysis` JSON into structured rows.
List<StatementAnalysisEntry> parseStatementAnalysisJson(String? raw) {
  if (raw == null || raw.isEmpty) return [];
  try {
    final d = jsonDecode(raw);
    if (d is! List<dynamic>) return [];
    final out = <StatementAnalysisEntry>[];
    for (final x in d) {
      if (x is Map<String, dynamic>) {
        out.add(
          StatementAnalysisEntry(
            statement: '${x['statement'] ?? ''}'.trim(),
            verdict: '${x['verdict'] ?? ''}'.trim(),
            reason: '${x['reason'] ?? ''}'.trim(),
          ),
        );
      }
    }
    return out;
  } catch (_) {
    return [];
  }
}

/// Decodes `elimination_logic` JSON array of strings.
List<String> decodeEliminationLines(String? raw) {
  if (raw == null || raw.isEmpty) return [];
  try {
    final d = jsonDecode(raw);
    if (d is List) {
      return d.map((e) => '$e'.trim()).where((s) => s.isNotEmpty).toList();
    }
  } catch (_) {}
  return [];
}

/// Classifies one elimination line for letter + confirm/eliminate colouring.
EliminationRowModel parseEliminationRow(String line) {
  final confirm = RegExp(
    r'Confirm\s+option\s*\(?([a-d])\)?',
    caseSensitive: false,
  ).firstMatch(line);
  if (confirm != null) {
    return EliminationRowModel(
      text: line,
      optionLetter: confirm.group(1)!.toLowerCase(),
      isConfirmedOption: true,
    );
  }
  final elim = RegExp(
    r'Eliminate\s+option\s*\(?([a-d])\)?',
    caseSensitive: false,
  ).firstMatch(line);
  if (elim != null) {
    return EliminationRowModel(
      text: line,
      optionLetter: elim.group(1)!.toLowerCase(),
      isConfirmedOption: false,
    );
  }
  return EliminationRowModel(text: line);
}
