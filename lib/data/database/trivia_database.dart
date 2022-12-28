import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TriviaDatabase {
  TriviaDatabase(String path) {
    db = openDatabase(
      join(path, 'dota_trivia.db'),
      version: 13,
      onCreate: ((db, version) async {
        // templates data
        await _createTemplatesTable(db);

        // odotaconstants data
        await _createHeroesTable(db);
        await _createItemsTable(db);
        await _createAbilitiesTable(db);

        // game data
        await _createQuestionsTable(db);
        await _createOptionsTable(db);
        await _createPlayerStatsTable(db);
        await _createTriviaSessionsTable(db);
        await _createTriviaLogsTable(db);
      }),
      onUpgrade: (db, oldVersion, newVersion) async {
        if (newVersion == 6) {
          await _upgradeTemplatesTable(db);
        }

        if (newVersion == 10) {
          await _upgradeHeroesTable(db);
        }

        if (newVersion == 11) {
          await _createItemsTable(db);
        }

        if (newVersion == 12) {
          await _createAbilitiesTable(db);
        }

        if (newVersion == 13) {
          await _createQuestionsTable(db);
        }
      },
    );
  }

  Future<Database>? db;

  /// Create templates table
  Future<void> _createTemplatesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        template_id INTEGER NULL,
        question TEXT NULL,
        content_type TEXT NULL,
        option_type TEXT NULL,
        source_data TEXT NULL
      )
    ''');
  }

  /// Create heroes table
  Future<void> _createHeroesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS heroes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          hero_id INTEGER NULL,
          name TEXT NULL,
          localized_name TEXT NULL,
          primary_attr TEXT NULL,
          attack_type TEXT NULL,
          roles TEXT NULL,
          img TEXT NULL,
          icon TEXT NULL,
          base_health INTEGER NULL,
          base_health_regen REAL NULL,
          base_mana INTEGER NULL,
          base_mana_regen REAL NULL,
          base_armor REAL NULL,
          base_mr INTEGER NULL,
          base_attack_min INTEGER NULL,
          base_attack_max INTEGER NULL,
          base_str INTEGER NULL,
          base_agi INTEGER NULL,
          base_int INTEGER NULL,
          str_gain REAL NULL,
          agi_gain REAL NULL,
          int_gain REAL NULL,
          attack_range INTEGER NULL,
          projectile_speed INTEGER NULL,
          attack_rate REAL NULL,
          base_attack_time INTEGER NULL,
          attack_point REAL NULL,
          move_speed INTEGER NULL,
          turn_rate REAL NULL,
          cm_enabled INTEGER NULL,
          legs INTEGER NULL,
          day_vision INTEGER NULL,
          night_vision INTEGER NULL,
          abilities TEXT NULL
        )
    ''');
  }

  Future<void> _createItemsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT NULL,
        item_id INTEGER NULL,
        img TEXT NULL,
        dname TEXT NULL,
        qual TEXT NULL,
        cost INTEGER NULL,
        notes TEXT NULL,
        mc INTEGER NULL,
        cd INTEGER NULL,
        lore TEXT NULL,
        components TEXT NULL,
        created INTEGER NULL,
        charges INTEGER NULL,
        tier INTEGER NULL
      )
    ''');
  }

  Future<void> _createAbilitiesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS abilities(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT NULL,
        dname TEXT NULL,
        behaviour TEXT NULL,
        dmg_type TEXT NULL,
        bkbpierce TEXT NULL,
        desc TEXT NULL,
        lore TEXT NULL,
        img TEXT NULL,
        cd TEXT NULL,
        mc TEXT NULL
      )
    ''');
  }

  // Create player_stats table
  Future<void> _createPlayerStatsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS player_stats(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        high_score INTEGER NULL,
        total_attempts INTEGER NULL
      )
    ''');
  }

  // Create trivia_sessions table
  Future<void> _createTriviaSessionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS trivia_sessions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        total_scores INTEGER NULL,
        total_questions INTEGER NULL,
        question_ids TEXT NULL,
        timestamp INTEGER NULL
      )
    ''');
  }

  // Create trivia_logs table
  Future<void> _createTriviaLogsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS trivia_logs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question_id INTEGER NULL,
        player_opt TEXT NULL,
        correct_opt TEXT NULL,
        trivia_session_id INTEGER NULL,
        timestamp INTEGER NULL
      )
    ''');
  }

  /// Create questions table
  Future<void> _createQuestionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NULL,
        content_url TEXT NULL,
        template_id INTEGER NULL
      )
    ''');
  }

  /// Create options table
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

  /// Upgrade templates table
  Future<void> _upgradeTemplatesTable(Database db) async {
    await db.execute('DROP TABLE templates');
    await _createTemplatesTable(db);
  }

  /// Upgrade heroes table
  Future<void> _upgradeHeroesTable(Database db) async {
    await db.execute('DROP TABLE heroes');
    await _createHeroesTable(db);
  }
}
