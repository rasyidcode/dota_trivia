import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TriviaDatabase {
  TriviaDatabase(String path) {
    db = openDatabase(
      join(path, 'dota_trivia.db'),
      version: 2,
      onCreate: ((db, version) async {
        await _createTemplatesTable(db);
        await _createQuestionsTable(db);
        await _createOptionsTable(db);
        await _createHeroesTable(db);
      }),
      onUpgrade: (db, oldVersion, newVersion) async {
        if (newVersion == 2) {
          await _createQuestionsTable(db);
        }

        if (oldVersion == 2 && newVersion == 3) {
          await _createTemplatesTableV2(db);
        }
      },
    );
  }

  Future<Database>? db;

  Future<void> _createHeroesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS heroes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          code TEXT NULL,
          name TEXT NULL,
          primary_attr TEXT NULL,
          attack_type TEXT NULL,
          image_url TEXT NULL,
          icon_url TEXT NULL,
          move_speed INTEGER NULL,
          legs INTEGER NULL
        )
    ''');
  }

  Future<void> _createTemplatesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS templates (
        id INTEGER PRIMARY KEY,
        question TEXT NULL,
        option_type TEXT NULL
      )
    ''');
  }

  Future<void> _createTemplatesTableV2(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS templates (
        id INTEGER PRIMARY KEY,
        template_id INTEGER NULL,
        question TEXT NULL,
        option_type TEXT NULL,
        source_data TEXT NULL
      )
    ''');
  }

  Future<void> _createQuestionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NULL,
        image_url TEXT NULL,
        template_id INTEGER NULL
      )
    ''');
  }

  Future<void> _createOptionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS options (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question_id INTEGER NULL,
        label TEXT NULL,
        content TEXT NULL,
        is_correct INTEGER NULL,
        icon_url TEXT NULL
      )
    ''');
  }
}
