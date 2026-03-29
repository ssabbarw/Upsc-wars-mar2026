import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


/// Singleton that manages the SQLite database connection.
///
/// Features access the database via [appDatabaseProvider] (see
/// core/providers/database_provider.dart). Do not use this class directly
/// in UI or domain code.
///
/// Schema changes: increment [_version] and add a migration block in [_onUpgrade].
class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const String _dbName = 'upsc_wars.db';
  static const int _version = 1;

  Database? _database;

  Future<Database> get database async {
    _database ??= await _init();
    return _database!;
  }

  Future<Database> _init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Called once on first install. Create all tables here.
  Future<void> _onCreate(Database db, int version) async {
    // TODO: add CREATE TABLE statements as features are built.
    // Example:
    // await db.execute('''
    //   CREATE TABLE topics (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     title TEXT NOT NULL,
    //     created_at INTEGER NOT NULL
    //   )
    // ''');
  }

  /// Called when [_version] is incremented. Add ALTER TABLE / new CREATE TABLE
  /// statements here so existing installs migrate without data loss.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Example migration guard pattern:
    // if (oldVersion < 2) { await db.execute('ALTER TABLE ...'); }
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
