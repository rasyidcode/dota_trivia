import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TriviaDatabase {
  TriviaDatabase(String path) {
    _db = openDatabase(
      join(path, 'dota_trivia.db'),
      version: 1,
      onCreate: ((db, version) async {
        await _createQuestionsTable(db);
        await _createOptionsTable(db);
      }),
    );
  }

  Future<Database>? _db;

  Future<Database>? getDatabase() {
    return _db;
  }

  Future<void> _createQuestionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NULL,
        image_url TEXT NULL,
        option_type TEXT NULL,
        template_id INTEGER NULL,
        hide_label INTEGER NULL
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
        correct INTEGER NULL,
        icon_url TEXT NULL
      )
    ''');
  }
}
