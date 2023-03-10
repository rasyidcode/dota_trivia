import 'package:dota_trivia/data/database/trivia_database.dart';
import 'package:dota_trivia/data/model/common/option.dart';
import 'package:dota_trivia/data/model/hero.dart';
import 'package:dota_trivia/data/model/question.dart';
import 'package:dota_trivia/data/model/template.dart';
import 'package:sqflite/sqflite.dart';

class TriviaProvider {
  TriviaProvider(this._triviaDatabase);

  final TriviaDatabase _triviaDatabase;

  Future<List<Hero>> getHero(int id) async {
    final heroes = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM heroes WHERE id = ?', [id]);

    if (heroes == null) {
      throw TriviaProviderException('Heroes returns null');
    }

    if (heroes.isEmpty) {
      throw TriviaProviderException('Heroes returns empty');
    }

    return heroes
        .map((h) => Hero.fromJson({
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

  Future<List<Hero>> getRandomHeroesNames(int count) async {
    final heroes = await (await _triviaDatabase.db)?.rawQuery('''
        SELECT
          id,
          localized_name,
          img
        FROM
          heroes
        ORDER BY RANDOM() ASC LIMIT ?
        ''', [count]);

    if (heroes == null) {
      throw TriviaProviderException('Heroes returns null');
    }

    if (heroes.isEmpty) {
      throw TriviaProviderException('Heroes returns empty');
    }

    return heroes
        .map((h) => Hero.fromJson({
              'id': h['id'],
              'localized_name': h['localized_name'],
              'img': h['img']
            }))
        .toList();
  }

  Future<List<int>> getRandomHeroesMoveSpeed(int count) async {
    final ms = await (await _triviaDatabase.db)?.rawQuery('''
        SELECT DISTINCT
          move_speed
        FROM
          heroes
        ORDER BY RANDOM() ASC LIMIT ?
        ''', [count]);

    if (ms == null) {
      throw TriviaProviderException('Heroes returns null');
    }

    if (ms.isEmpty) {
      throw TriviaProviderException('Heroes returns empty');
    }

    return ms.map((m) => m['move_speed'] as int).toList();
  }

  Future<Hero> getRandomHeroByMoveSpeed(int ms) async {
    final heroes = await (await _triviaDatabase.db)?.rawQuery('''
        SELECT
          id,
          localized_name,
          img,
          move_speed
        FROM
          heroes
        WHERE move_speed = ?
        ORDER BY RANDOM() ASC LIMIT ?
        ''', [ms, 1]);

    if (heroes == null) {
      throw TriviaProviderException('Heroes returns null');
    }

    if (heroes.isEmpty) {
      throw TriviaProviderException('Heroes returns empty');
    }

    return heroes
        .map((h) => Hero.fromJson({
              'id': h['id'],
              'localized_name': h['localized_name'],
              'img': h['img'],
              'move_speed': h['move_speed'],
            }))
        .toList()
        .first;
  }

  Future<List<Map<String, int?>>> getRandomHeroesAttackDamage(int count) async {
    final heroes = await (await _triviaDatabase.db)?.rawQuery('''
      SELECT DISTINCT
        base_attack_min,
        base_attack_max
      FROM
        heroes
      ORDER BY RANDOM() ASC LIMIT ?''', [count]);

    if (heroes == null) {
      throw TriviaProviderException('Heroes returns null');
    }

    if (heroes.isEmpty) {
      throw TriviaProviderException('Heroes returns empty');
    }

    return heroes
        .map((h) => {
              'base_attack_min': h['base_attack_min'] as int?,
              'base_attack_max': h['base_attack_max'] as int?,
            })
        .toList();
  }

  Future<Hero> getRandomHeroByAttackDamage(int min, int max) async {
    final heroes = await (await _triviaDatabase.db)?.rawQuery('''
      SELECT
        id,
        localized_name,
        img,
        primary_attr,
        base_attack_min,
        base_attack_max,
        base_str,
        base_agi,
        base_int
      FROM
        heroes
      WHERE
        base_attack_min = ? AND base_attack_max = ?
      ORDER BY RANDOM() ASC LIMIT ?''', [min, max, 1]);

    if (heroes == null) {
      throw TriviaProviderException('Heroes returns null');
    }

    if (heroes.isEmpty) {
      throw TriviaProviderException('Heroes returns empty');
    }

    return heroes
        .map((h) => Hero.fromJson({
              'id': h['id'],
              'localized_name': h['localized_name'],
              'img': h['img'],
              'primary_attr': h['primary_attr'],
              'base_attack_min': h['base_attack_min'],
              'base_attack_max': h['base_attack_max'],
              'base_str': h['base_str'],
              'base_agi': h['base_agi'],
              'base_int': h['base_int'],
            }))
        .toList()
        .first;
  }

  Future<List<double?>> getRandomHeroesArmor(int count) async {
    final heroes = await (await _triviaDatabase.db)?.rawQuery('''
      SELECT DISTINCT
        base_armor
      FROM
        heroes
      ORDER BY RANDOM() ASC LIMIT ?''', [count]);

    if (heroes == null) {
      throw TriviaProviderException('Heroes returns null');
    }

    if (heroes.isEmpty) {
      throw TriviaProviderException('Heroes returns empty');
    }

    return heroes.map((h) => h['base_armor'] as double?).toList();
  }

  Future<Hero> getRandomHeroByArmor(double armor) async {
    final heroes = await (await _triviaDatabase.db)?.rawQuery('''
      SELECT
        id,
        localized_name,
        img,
        base_armor,
        base_agi
      FROM
        heroes
      WHERE
        base_armor = ?
      ORDER BY RANDOM() ASC LIMIT ?''', [armor, 1]);

    if (heroes == null) {
      throw TriviaProviderException('Heroes returns null');
    }

    if (heroes.isEmpty) {
      throw TriviaProviderException('Heroes returns empty');
    }

    return heroes
        .map((h) => Hero.fromJson({
              'id': h['id'],
              'localized_name': h['localized_name'],
              'img': h['img'],
              'base_armor': h['base_armor'],
              'base_agi': h['base_agi'],
            }))
        .toList()
        .first;
  }

  Future<Template> getTemplateById(int id) async {
    final templates = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM templates WHERE template_id = ?', [id]);

    if (templates == null) {
      throw TriviaProviderException('Template returns null');
    }

    if (templates.isEmpty) {
      throw TriviaProviderException('Template returns empty');
    }

    return templates
        .map((t) => Template.fromJson({
              'id': t['id'],
              'template_id': t['template_id'],
              'question': t['question'],
              'content_type': t['content_type'],
              'option_type': t['option_type'],
              'source_data': t['source_data'].toString().split(',')
            }))
        .toList()
        .first;
  }

  Future<List<Template>> getTemplates() async {
    final template = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM templates ORDER BY id ASC');

    if (template == null) {
      throw TriviaProviderException('List template returns null');
    }

    if (template.isEmpty) {
      throw TriviaProviderException('List template returns empty');
    }

    return template.map((t) => Template.fromJson(t)).toList();
  }

  Future<Template> getRandomTemplate() async {
    final template = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM templates ORDER BY id ASC');

    if (template == null) {
      throw TriviaProviderException('List template returns null');
    }

    if (template.isEmpty) {
      throw TriviaProviderException('List template returns empty');
    }

    return (template.map((t) => Template.fromJson(t)).toList()..shuffle())
        .first;
  }

  /// Get a question
  Future<Question> getLastQuestion() async {
    final question = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM questions ORDER BY id DESC LIMIT 1');

    if (question == null) {
      throw TriviaProviderException('Question returns null');
    }

    if (question.isEmpty) {
      throw TriviaProviderException('Question returns empty');
    }

    return (question
            .map((q) => Question.fromJson({
                  'id': q['id'],
                  'question': q['question'],
                  'content_url': q['content_url'],
                  'template_id': q['template_id'],
                }))
            .toList())
        .first;
  }

  /// Get Options by [qid] or Question Id
  Future<List<Option>> getOptions(int qid) async {
    final question = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM options WHERE question_id = ?', [qid]);

    if (question == null) {
      throw TriviaProviderException('Question returns null');
    }

    if (question.isEmpty) {
      throw TriviaProviderException('Question returns empty');
    }

    return (question
        .map((o) => Option.fromJson({
              'id': o['id'],
              'question_id': o['question_id'],
              'label': o['label'],
              'content': o['content'],
              'is_correct': (o['is_correct'] as int) == 1,
              'icon_url': o['icon_url'],
            }))
        .toList());
  }

  /// Insert a new question
  Future<int> insertQuestion(Question q) async {
    try {
      int? id = await (await _triviaDatabase.db)?.rawInsert(
          'INSERT INTO questions(question, content_url, template_id) VALUES(?, ?, ?)',
          [q.question, q.contentUrl, q.templateId]);

      if (id == null) {
        throw TriviaProviderException('ID returns null');
      }

      return id;
    } on DatabaseException catch (e) {
      throw TriviaProviderException(
          'Error: ${e.getResultCode()}, ${e.toString()}');
    }
  }

  /// Insert options
  Future<void> insertOptions(List<Option> opts, int qid) async {
    Batch? batch = (await _triviaDatabase.db)?.batch();
    for (var opt in opts) {
      int isCorrect;
      if (opt.isCorrect != null) {
        isCorrect = opt.isCorrect! ? 1 : 0;
      } else {
        isCorrect = 0;
      }

      batch?.rawInsert(
          'INSERT INTO options(question_id, label, content, is_correct) VALUES(?, ?, ?, ?)',
          [qid, opt.label, opt.content, isCorrect]);
    }

    await batch?.commit(noResult: true);
  }
}

class TriviaProviderException implements Exception {
  TriviaProviderException(this.message);

  final String message;
}
