import 'package:dota_trivia/data/database/trivia_database.dart';
import 'package:dota_trivia/data/model/common/option_item.dart';
import 'package:dota_trivia/data/model/hero_item.dart';
import 'package:dota_trivia/data/model/question_item.dart';
import 'package:dota_trivia/data/model/template_item.dart';
import 'package:dota_trivia/data/provider/trivia_provider_exception.dart';
import 'package:sqflite/sqflite.dart';

class TriviaProvider {
  TriviaProvider(this._triviaDatabase);

  final TriviaDatabase _triviaDatabase;

  Future<void> clearTemplates() async {
    await (await _triviaDatabase.db)?.rawDelete('DELETE FROM templates');
  }

  Future<void> clearHeroes() async {
    await (await _triviaDatabase.db)?.rawDelete('DELETE FROM heroes');
  }

  Future<void> saveTemplates(List<Map<String, dynamic>> templates) async {
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
      throw TriviaProviderException(
          'Error: ${e.result}, ${e.getResultCode()}, ${e.toString()}');
    }
  }

  Future<void> saveHeroes(Map<String, dynamic> heroes) async {
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

  Future<List<HeroItem>> getHeroes() async {
    final heroes = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM heroes ORDER BY id ASC');

    if (heroes == null) {
      throw TriviaProviderException('Heroes returns null');
    }

    if (heroes.isEmpty) {
      throw TriviaProviderException('Heroes returns empty');
    }

    return heroes.map((h) => HeroItem.fromJson(h)).toList();
  }

  Future<TemplateItem> getTemplateById(int id) async {
    final templates = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM templates WHERE id = ?', [id]);

    if (templates == null) {
      throw TriviaProviderException('Template returns null');
    }

    if (templates.isEmpty) {
      throw TriviaProviderException('Template returns empty');
    }

    return templates.map((t) => TemplateItem.fromJson(t)).toList().first;
  }

  Future<List<TemplateItem>> getTemplates() async {
    final template = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM templates ORDER BY id ASC');

    if (template == null) {
      throw TriviaProviderException('List template returns null');
    }

    if (template.isEmpty) {
      throw TriviaProviderException('List template returns empty');
    }

    return template.map((t) => TemplateItem.fromJson(t)).toList();
  }

  Future<TemplateItem> getRandomTemplate() async {
    final template = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM templates ORDER BY id ASC');

    if (template == null) {
      throw TriviaProviderException('List template returns null');
    }

    if (template.isEmpty) {
      throw TriviaProviderException('List template returns empty');
    }

    return (template.map((t) => TemplateItem.fromJson(t)).toList()..shuffle())
        .first;
  }

  /// Insert a new question
  Future<int> insertQuestion(QuestionItem q) async {
    try {
      int? id = await (await _triviaDatabase.db)?.rawInsert(
          'INSERT INTO questions(question, image_url, template_id) VALUES(?, ?, ?)',
          [q.question, q.imageUrl, q.templateId]);

      if (id == null) {
        throw TriviaProviderException('ID returns null');
      }

      return id;
    } on DatabaseException catch (e) {
      throw TriviaProviderException(
          'Error: ${e.getResultCode()}, ${e.toString()}');
    }
  }

  /// Get a question
  Future<QuestionItem> getLastQuestion() async {
    final question = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM questions ORDER BY id DESC LIMIT 1');

    if (question == null) {
      throw TriviaProviderException('Question returns null');
    }

    if (question.isEmpty) {
      throw TriviaProviderException('Question returns empty');
    }

    return (question.map((q) => QuestionItem.fromJson(q)).toList()).first;
  }

  /// Insert options
  Future<void> insertOptions(List<OptionItem> opts, int qid) async {
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

  /// Get Options by [qid] or Question Id
  Future<List<OptionItem>> getOptions(int qid) async {
    final question = await (await _triviaDatabase.db)
        ?.rawQuery('SELECT * FROM options WHERE question_id = ?', [qid]);

    if (question == null) {
      throw TriviaProviderException('Question returns null');
    }

    if (question.isEmpty) {
      throw TriviaProviderException('Question returns empty');
    }

    return (question
        .map((o) => OptionItem.fromJson({
              'id': o['id'],
              'question_id': o['question_id'],
              'label': o['label'],
              'content': o['content'],
              'is_correct': (o['is_correct'] as int) == 1,
              'icon_url': o['icon_url'],
            }))
        .toList());
  }
}
