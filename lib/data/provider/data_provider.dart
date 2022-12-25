import 'package:dota_trivia/data/database/trivia_database.dart';
import 'package:sqflite/sqflite.dart';

class DataProvider {
  DataProvider(this._triviaDatabase);

  final TriviaDatabase _triviaDatabase;

  /// Insert batch heroes
  Future<void> insertHeroes(Map<String, dynamic> heroes) async {
    Batch? batch = (await _triviaDatabase.db)?.batch();

    heroes.forEach(
      (_, hero) => batch?.rawInsert(
        'INSERT INTO heroes (code, name, primary_attr, attack_type, image_url, icon_url, move_speed, legs) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
        [
          hero['name'],
          hero['localized_name'],
          hero['primary_attr'],
          hero['attack_type'],
          hero['img'],
          hero['icon'],
          hero['move_speed'],
          hero['legs'],
        ],
      ),
    );

    await batch?.commit(noResult: true);
  }

  /// Clear heroes data
  Future<void> clearHeroes() async {
    await (await _triviaDatabase.db)?.rawDelete('DELETE FROM heroes');
  }

  /// Check if heroes data exist
  Future<bool> isHeroesDataExist() async {
    final counts = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT COUNT(*) as count FROM heroes');

    if (counts == null) {
      throw DataProviderException('Counts hero returns null');
    }

    if (counts.isEmpty) {
      throw DataProviderException('Counts hero returns empty');
    }

    int? count = counts.first['count'] as int?;
    if (count == null) {
      throw DataProviderException('Count is not defined');
    }

    return count > 0;
  }

  /// Clear templates data
  Future<void> clearTemplates() async {
    await (await _triviaDatabase.db)?.rawDelete('DELETE FROM templates');
  }

  /// Insert batch templates
  Future<void> insertTemplates(List<Map<String, dynamic>> templates) async {
    Batch? batch = (await _triviaDatabase.db)?.batch();

    for (var template in templates) {
      batch?.rawInsert(
        'INSERT INTO templates (id, question, option_type) VALUES(?,?,?)',
        [
          template['id'],
          template['question'],
          template['option_type'],
        ],
      );
    }

    try {
      await batch?.commit(noResult: true);
    } on DatabaseException catch (e) {
      throw DataProviderException(
          'Error: ${e.result}, ${e.getResultCode()}, ${e.toString()}');
    }
  }

  /// Check if template data exist
  Future<bool> isTemplatesDataExist() async {
    final counts = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT COUNT(*) as count FROM templates');

    if (counts == null) {
      throw DataProviderException('Counts template returns null');
    }

    if (counts.isEmpty) {
      throw DataProviderException('Counts template returns empty');
    }

    int? count = counts.first['count'] as int?;
    if (count == null) {
      throw DataProviderException('Count is not defined');
    }

    return count > 0;
  }
}

class DataProviderException implements Exception {
  DataProviderException(this.message);

  final String message;
}
