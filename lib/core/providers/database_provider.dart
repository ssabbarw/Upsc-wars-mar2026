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
///
/// [keepAlive] keeps the connection open for the app lifetime. [ref.onDispose]
/// must be registered **before** any `await` — otherwise if this provider is
/// disposed while [AppDatabase.instance.database] is still resolving,
/// registering a dispose callback throws [StateError].
@Riverpod(keepAlive: true)
Future<Database> appDatabase(AppDatabaseRef ref) async {
  ref.onDispose(AppDatabase.instance.close);
  return AppDatabase.instance.database;
}
