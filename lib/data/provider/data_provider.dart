import 'package:dota_trivia/data/database/trivia_database.dart';
import 'package:dota_trivia/data/model/hero_item.dart';
import 'package:dota_trivia/data/model/item.dart';
import 'package:dota_trivia/data/model/template_item.dart';
import 'package:dota_trivia/data/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

/// Check table info sql
/// > PRAGMA table_info(heroes)

class DataProvider extends BaseProvider {
  DataProvider(this._triviaDatabase) : super(_triviaDatabase);

  final TriviaDatabase _triviaDatabase;

  /// Clear templates data
  Future<void> clearTemplates() async => await clearData(table: 'templates');

  /// Clear heroes data
  Future<void> clearHeroes() async => await clearData(table: 'heroes');

  /// Clear items data
  Future<void> clearItems() async => await clearData(table: 'items');

  /// Clear hero_abilities data
  Future<void> clearHeroAbilities() async =>
      await clearData(table: 'hero_abilities');

  /// Clear abilities data
  Future<void> clearAbilities() async => await clearData(table: 'abilities');

  /// Insert batch templates
  Future<void> insertTemplates(List<Map<String, dynamic>> templates) async {
    Batch? batch = (await _triviaDatabase.db)?.batch();

    for (var template in templates) {
      batch?.rawInsert('''
        INSERT INTO templates
          (template_id, question, content_type, option_type, source_data, info, level)
        VALUES
          (?, ?, ?, ?, ?, ?, ?)
      ''', [
        template['id'],
        template['question'],
        template['content_type'],
        template['option_type'],
        (template['source_data'] as List).join(','),
        template['info'],
        template['level'],
      ]);
    }

    try {
      await batch?.commit(noResult: true);
    } on DatabaseException catch (e) {
      if (kDebugMode) {
        print('Error: ${e.result}, ${e.getResultCode()}, ${e.toString()}');
      }
      throw DataProviderException('Insert templates error');
    }
  }

  /// Insert batch heroes
  Future<void> insertHeroes(
    Map<String, dynamic> heroes,
    Map<String, dynamic> abilities,
  ) async {
    Batch? batch = (await _triviaDatabase.db)?.batch();

    heroes.forEach(
      (_, hero) => batch?.rawInsert(
        '''
        INSERT INTO heroes (
          hero_id,
          name,
          localized_name,
          primary_attr,
          roles,
          img,
          icon,
          base_health,
          base_health_regen,
          base_mana,
          base_mana_regen,
          base_armor,
          base_mr,
          base_attack_min,
          base_attack_max,
          base_str,
          base_agi,
          base_int,
          str_gain,
          agi_gain,
          int_gain,
          attack_range,
          projectile_speed,
          attack_rate,
          base_attack_time,
          attack_point,
          move_speed,
          turn_rate,
          cm_enabled,
          legs,
          day_vision,
          night_vision,
          abilities
        ) VALUES (
            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
            ?, ?, ?)
      ''',
        [
          hero['id'],
          hero['name'],
          hero['localized_name'],
          hero['primary_attr'],
          List<String>.from(hero['roles']).join(','),
          hero['img'],
          hero['icon'],
          hero['base_health'],
          hero['base_health_regen'],
          hero['base_mana'],
          hero['base_mana_regen'],
          hero['base_armor'],
          hero['base_mr'],
          hero['base_attack_min'],
          hero['base_attack_max'],
          hero['base_str'],
          hero['base_agi'],
          hero['base_int'],
          hero['str_gain'],
          hero['agi_gain'],
          hero['int_gain'],
          hero['attack_range'],
          hero['projectile_speed'],
          hero['attack_rate'],
          hero['base_attack_time'],
          hero['attack_point'],
          hero['move_speed'],
          hero['turn_rate'],
          hero['cm_enabled'],
          hero['legs'],
          hero['day_vision'],
          hero['night_vision'],
          List<String>.from(abilities[hero['name']]['abilities']).join(',')
        ],
      ),
    );

    try {
      await batch?.commit(noResult: true);
    } on DatabaseException catch (e) {
      if (kDebugMode) {
        print('Error: ${e.result}}');
      }
      throw DataProviderException('Insert heroes error');
    }
  }

  /// Insert batch templates
  Future<void> insertItems(Map<String, dynamic> items) async {
    Batch? batch = (await _triviaDatabase.db)?.batch();

    items.forEach((key, item) {
      batch?.rawInsert('''
        INSERT INTO items (
          code,
          item_id,
          img,
          dname,
          qual,
          cost,
          notes,
          mc,
          cd,
          lore,
          components,
          created,
          charges,
          tier
        ) VALUES (?, ?, ?, ?, ?,
                  ?, ?, ?, ?, ?,
                  ?, ?, ?, ?)
      ''', [
        key,
        item['id'],
        item['img'],
        item['dname'],
        item['qual'],
        item['cost'],
        item['notes'],
        item['mc'].runtimeType == bool ? 0 : item['mc'],
        item['cd'].runtimeType == bool ? 0 : item['cd'],
        item['lore'],
        item['components'] == null
            ? null
            : List<String>.from(item['components']).join(','),
        (item['created'] as bool) ? 1 : 0,
        item['charges'].runtimeType == bool ? 0 : items['charges'],
        item['tier']
      ]);
    });

    try {
      await batch?.commit(noResult: true);
    } on DatabaseException catch (e) {
      if (kDebugMode) {
        print('Error: ${e.result}, ${e.getResultCode()}, ${e.toString()}');
      }
      throw DataProviderException('Insert items error');
    }
  }

  /// Insert abilities
  Future<void> insertAbilities(Map<String, dynamic> abilities) async {
    Batch? batch = (await _triviaDatabase.db)?.batch();

    abilities.forEach((key, ability) {
      batch?.rawInsert('''
        INSERT INTO abilities (
          code,
          dname,
          behaviour,
          dmg_type,
          bkbpierce,
          desc,
          lore,
          img,
          cd,
          mc
        ) VALUES
          (?, ?, ?, ?, ?,
           ?, ?, ?, ?, ?)
      ''', [
        key,
        ability['dname'],
        ability['behaviour'],
        ability['dmg_type'],
        ability['bkbpierce'],
        ability['desc'],
        ability['lore'],
        ability['img'],
        ability['cd'] != null
            ? (ability['cd'].runtimeType == String
                ? ability['cd']
                : List<String>.from(ability['cd']).join(','))
            : null,
        ability['mc'] != null
            ? (ability['mc'].runtimeType == String
                ? ability['mc']
                : List<String>.from(ability['mc']).join(','))
            : null,
      ]);
    });

    try {
      await batch?.commit(noResult: true);
    } on DatabaseException catch (e) {
      if (kDebugMode) {
        print('Error: ${e.result}, ${e.getResultCode()}, ${e.toString()}');
      }
      throw DataProviderException('Insert templates error');
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

  /// Check if items data exist
  Future<bool> isItemsDataExist() async {
    final counts = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT COUNT(*) as count FROM items');

    if (counts == null) {
      throw DataProviderException('Counts items returns null');
    }

    if (counts.isEmpty) {
      throw DataProviderException('Counts items returns empty');
    }

    int? count = counts.first['count'] as int?;
    if (count == null) {
      throw DataProviderException('Count is not defined');
    }

    return count > 0;
  }

  /// Check if abilities data exists
  Future<bool> isAbilitiesDataExist() async {
    final counts = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT COUNT(*) as count FROM abilities');

    if (counts == null) {
      throw DataProviderException('Counts abilities returns null');
    }

    if (counts.isEmpty) {
      throw DataProviderException('Counts abilities returns empty');
    }

    int? count = counts.first['count'] as int?;
    if (count == null) {
      throw DataProviderException('Count is not defined');
    }

    return count > 0;
  }

  /// Get all templates
  Future<List<TemplateItem>> getTemplates() async {
    final templates = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM templates ORDER BY id ASC');

    if (templates == null) {
      throw DataProviderException('Templates returns null');
    }

    if (templates.isEmpty) {
      throw DataProviderException('Templates returns empty');
    }

    return templates
        .map((t) => TemplateItem.fromJson({
              'id': t['id'],
              'template_id': t['template_id'],
              'question': t['question'],
              'content_type': t['content_type'],
              'option_type': t['option_type'],
              'source_data': (t['source_data'] as String).split(',')
            }))
        .toList();
  }

  /// Get all heroes
  Future<List<HeroItem>> getHeroes() async {
    final heroes = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM heroes ORDER BY id ASC');

    if (heroes == null) {
      throw DataProviderException('Heroes returns null');
    }

    if (heroes.isEmpty) {
      throw DataProviderException('Heroes returns empty');
    }

    return heroes
        .map((h) => HeroItem.fromJson({
              'id': h['id'],
              'hero_id': h['hero_id'],
              'name': h['name'],
              'localized_name': h['localized_name'],
              'primary_attr': h['primary_attr'],
              'attack_type': h['attack_type'],
              'roles': h['roles'].toString().split(','),
              'img': h['img'],
              'icon': h['icon'],
              'base_health': h['base_health'],
              'base_health_regen': h['base_health_regen'],
              'base_mana': h['base_mana'],
              'base_mana_regen': h['base_mana_regen'],
              'base_armor': h['base_armor'],
              'base_mr': h['base_mr'],
              'base_attack_min': h['base_attack_min'],
              'base_attack_max': h['base_attack_max'],
              'base_str': h['base_str'],
              'base_agi': h['base_agi'],
              'base_int': h['base_int'],
              'str_gain': h['str_gain'],
              'agi_gain': h['agi_gain'],
              'int_gain': h['int_gain'],
              'attack_range': h['attack_range'],
              'projectile_speed': h['projectile_speed'],
              'attack_rate': h['attack_rate'],
              'base_attack_time': h['base_attack_time'],
              'attack_point': h['attack_point'],
              'move_speed': h['move_speed'],
              'turn_rate': h['turn_rate'],
              'cm_enabled': h['cm_enabled'],
              'legs': h['legs'],
              'day_vision': h['day_vision'],
              'night_vision': h['night_vision'],
              'abilities': h['abilities'].toString().split(',')
            }))
        .toList();
  }

  /// Get all items
  Future<List<Item>> getItems() async {
    final items = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM items ORDER BY id ASC');

    if (items == null) {
      throw DataProviderException('Items returns null');
    }

    if (items.isEmpty) {
      throw DataProviderException('Items returns empty');
    }

    return items
        .map((i) => Item.fromJson({
              'id': i['id'],
              'code': i['code'],
              'item_id': i['item_id'],
              'img': i['img'],
              'dname': i['dname'],
              'qual': i['qual'],
              'cost': i['cost'],
              'notes': i['notes'],
              'mc': i['mc'],
              'cd': i['cd'],
              'lore': i['lore'],
              'components': i['components'] == null
                  ? i['components'].toString().split(',')
                  : null,
              'created': i['created'],
              'charges': i['charges'],
              'tier': i['tier'],
            }))
        .toList();
  }

  /// Get all abilities
}

class DataProviderException implements Exception {
  DataProviderException(this.message);

  final String message;
}
