import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upsc_wars_new/core/constants/subject_mcq_db_names.dart';
import 'package:upsc_wars_new/core/constants/subject_test_constants.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_question.dart';
import 'package:upsc_wars_new/features/practice_test/domain/entities/practice_table_data.dart';
import 'package:upsc_wars_new/features/practice_test/domain/repositories/practice_test_repository.dart';

/// SQLite implementation of [PracticeTestRepository].
class PracticeTestRepositoryImpl implements PracticeTestRepository {
  /// Creates the repository with an open [Database].
  PracticeTestRepositoryImpl(this._db);

  final Database _db;

  @override
  Future<Either<Failure, List<PracticeQuestion>>> loadTestQuestions({
    required String subjectId,
    required int testNumber,
  }) async {
    final dbSubject = SubjectMcqDbNames.dbSubjectForId(subjectId);
    if (dbSubject == null) {
      return left(const CacheFailure('Unknown subject'));
    }
    if (testNumber < 1) {
      return left(const CacheFailure('Invalid test number'));
    }

    final offset =
        (testNumber - 1) * SubjectTestConstants.questionsPerTest;
    final limit = SubjectTestConstants.questionsPerTest;

    try {
      final rows = await _db.rawQuery(
        '''
SELECT
  m.overall_que_no AS overall_que_no,
  m.subject_que_no AS subject_que_no,
  m.question_type AS question_type,
  m.has_table AS has_table,
  m.correct_option AS correct_option,
  m.bookmarked AS bookmarked,
  m.trap_type AS trap_type,
  m.concept_anchor AS concept_anchor,
  c.question_text AS question_text,
  c.display_text AS display_text,
  c.final_explanation AS final_explanation,
  c.upsc_trap_explanation AS upsc_trap_explanation,
  c.strong_distractor AS strong_distractor,
  c.elimination_logic AS elimination_logic,
  c.statement_analysis AS statement_analysis,
  t.header_text AS table_header,
  t.footer_text AS table_footer,
  t.rows AS table_rows,
  t.columns AS table_columns
FROM mcq_meta_data m
INNER JOIN mcq_content_en c ON m.overall_que_no = c.overall_que_no
LEFT JOIN mcqs_with_table_en t ON m.overall_que_no = t.overall_que_no
WHERE m.subject = ?
ORDER BY m.subject_que_no ASC
LIMIT ? OFFSET ?
''',
        [dbSubject, limit, offset],
      );

      if (rows.length < limit) {
        return left(const CacheFailure('Incomplete test data'));
      }

      final list = rows.map(_mapRow).toList();
      return right(list);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  PracticeQuestion _mapRow(Map<String, Object?> row) {
    final hasTable = (row['has_table'] as int? ?? 0) == 1;
    final co = row['correct_option'];
    final correct =
        co is String ? co.toLowerCase() : '${co ?? ''}'.toLowerCase();

    PracticeTableData? table;
    if (hasTable) {
      final colsJson = row['table_columns'] as String?;
      final rowsJson = row['table_rows'] as String?;
      table = PracticeTableData(
        headerText: row['table_header'] as String?,
        footerText: row['table_footer'] as String?,
        columns: _decodeStringList(colsJson),
        rows: _decodeGrid(rowsJson),
      );
    }

    return PracticeQuestion(
      overallQueNo: row['overall_que_no'] as int,
      subjectQueNo: row['subject_que_no'] as int,
      questionType: '${row['question_type'] ?? ''}',
      hasTable: hasTable,
      correctOption: correct,
      bookmarked: (row['bookmarked'] as int? ?? 0) == 1,
      questionText: '${row['question_text'] ?? ''}',
      displayText: row['display_text'] as String?,
      finalExplanation: row['final_explanation'] as String?,
      upscTrapExplanation: row['upsc_trap_explanation'] as String?,
      strongDistractor: row['strong_distractor'] as String?,
      eliminationLogicJson: row['elimination_logic'] as String?,
      statementAnalysisJson: row['statement_analysis'] as String?,
      trapType: row['trap_type'] as String?,
      conceptAnchor: row['concept_anchor'] as String?,
      table: table,
    );
  }

  static List<String> _decodeStringList(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw);
    if (decoded is! List) return [];
    return decoded.map((e) => '$e').toList();
  }

  static List<List<String>> _decodeGrid(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw);
    if (decoded is! List) return [];
    return decoded.map((row) {
      if (row is List) return row.map((e) => '$e').toList();
      return <String>[];
    }).toList();
  }

  @override
  Future<Either<Failure, Unit>> setBookmarked({
    required int overallQueNo,
    required bool bookmarked,
  }) async {
    try {
      await _db.update(
        'mcq_meta_data',
        {'bookmarked': bookmarked ? 1 : 0},
        where: 'overall_que_no = ?',
        whereArgs: [overallQueNo],
      );
      return right(unit);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}
