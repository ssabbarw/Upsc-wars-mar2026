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
  static const int _version = 2;

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
    await _createMcqMetaDataTables(db);
  }

  /// Called when [_version] is incremented. Add ALTER TABLE / new CREATE TABLE
  /// statements here so existing installs migrate without data loss.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createMcqMetaDataTables(db);
    }
  }

  static Future<void> _createMcqMetaDataTables(Database db) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS mcq_meta_data (
  overall_que_no INTEGER NOT NULL PRIMARY KEY,
  subject_que_no INTEGER NOT NULL,
  subject TEXT NOT NULL,
  topic TEXT NOT NULL,
  sub_topic TEXT,
  question_type TEXT NOT NULL,
  trap_type TEXT,
  concepts_used TEXT NOT NULL,
  concept_anchor TEXT,
  has_table INTEGER NOT NULL,
  user_attempt TEXT,
  correct_option TEXT NOT NULL
)
''');
    await db.execute('''
CREATE TABLE IF NOT EXISTS mcq_content_en (
  overall_que_no INTEGER NOT NULL PRIMARY KEY,
  subject_que_no INTEGER NOT NULL,
  question_text TEXT NOT NULL,
  display_text TEXT,
  final_explanation TEXT,
  upsc_trap_explanation TEXT,
  strong_distractor TEXT,
  elimination_logic TEXT,
  statement_analysis TEXT
)
''');
    await db.execute('''
CREATE TABLE IF NOT EXISTS mcqs_with_table_en (
  overall_que_no INTEGER NOT NULL PRIMARY KEY,
  subject_que_no INTEGER NOT NULL,
  header_text TEXT,
  footer_text TEXT,
  rows TEXT NOT NULL,
  columns TEXT NOT NULL
)
''');
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
