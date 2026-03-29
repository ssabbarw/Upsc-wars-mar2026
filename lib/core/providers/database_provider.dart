import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upsc_wars_new/core/database/app_database.dart';

part 'database_provider.g.dart';

/// Provides the open [Database] instance to the rest of the app.
///
/// Usage in a feature:
/// ```dart
/// final db = await ref.watch(appDatabaseProvider.future);
/// ```
@riverpod
Future<Database> appDatabase(Ref ref) async {
  final db = await AppDatabase.instance.database;
  ref.onDispose(AppDatabase.instance.close);
  return db;
}
