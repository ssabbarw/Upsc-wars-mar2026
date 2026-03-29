import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upsc_wars_new/core/errors/failures.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_item.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/entities/topic_wise_tag_list_source.dart';
import 'package:upsc_wars_new/features/topic_wise/domain/repositories/topic_wise_tags_repository.dart';

/// SQLite implementation that aggregates distinct tags from `mcq_meta_data`.
class TopicWiseTagsRepositoryImpl implements TopicWiseTagsRepository {
  /// Creates the repository with an open [Database].
  TopicWiseTagsRepositoryImpl(this._db);

  final Database _db;

  @override
  Future<Either<Failure, List<TopicWiseTagItem>>> listTagItems({
    required String dbSubjectName,
    required TopicWiseTagListSource source,
  }) async {
    try {
      switch (source) {
        case TopicWiseTagListSource.topic:
          return right(await _distinctTopicCounts(dbSubjectName));
        case TopicWiseTagListSource.subTopic:
          return right(await _distinctSubTopicCounts(dbSubjectName));
        case TopicWiseTagListSource.concepts:
          return right(await _conceptCounts(dbSubjectName));
      }
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  Future<List<TopicWiseTagItem>> _distinctTopicCounts(String subject) async {
    final rows = await _db.rawQuery(
      '''
SELECT topic AS label, COUNT(*) AS c
FROM mcq_meta_data
WHERE subject = ? AND TRIM(topic) != ''
GROUP BY topic
ORDER BY topic COLLATE NOCASE
''',
      [subject],
    );
    return _mapCountRows(rows);
  }

  Future<List<TopicWiseTagItem>> _distinctSubTopicCounts(String subject) async {
    final rows = await _db.rawQuery(
      '''
SELECT sub_topic AS label, COUNT(*) AS c
FROM mcq_meta_data
WHERE subject = ?
  AND sub_topic IS NOT NULL
  AND TRIM(sub_topic) != ''
GROUP BY sub_topic
ORDER BY sub_topic COLLATE NOCASE
''',
      [subject],
    );
    return _mapCountRows(rows);
  }

  Future<List<TopicWiseTagItem>> _conceptCounts(String subject) async {
    final rows = await _db.rawQuery(
      '''
SELECT concepts_used FROM mcq_meta_data WHERE subject = ?
''',
      [subject],
    );
    final counts = <String, int>{};
    for (final row in rows) {
      final raw = row['concepts_used'] as String?;
      if (raw == null || raw.isEmpty) continue;
      final decoded = jsonDecode(raw);
      if (decoded is! List<dynamic>) continue;
      final seenInRow = <String>{};
      for (final e in decoded) {
        final label = '$e'.trim();
        if (label.isEmpty) continue;
        seenInRow.add(label);
      }
      for (final label in seenInRow) {
        counts[label] = (counts[label] ?? 0) + 1;
      }
    }
    final list = counts.entries
        .map(
          (e) => TopicWiseTagItem(label: e.key, questionCount: e.value),
        )
        .toList()
      ..sort(
        (a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()),
      );
    return list;
  }

  List<TopicWiseTagItem> _mapCountRows(List<Map<String, Object?>> rows) {
    return rows
        .map(
          (r) => TopicWiseTagItem(
            label: '${r['label'] ?? ''}',
            questionCount: (r['c'] as num?)?.toInt() ?? 0,
          ),
        )
        .where((e) => e.label.isNotEmpty)
        .toList();
  }
}
