import 'package:dota_trivia/constants/templates.dart';
import 'package:dota_trivia/data/model/common/option.dart';
import 'package:dota_trivia/data/model/hero.dart';
import 'package:dota_trivia/data/model/question.dart';
import 'package:dota_trivia/data/model/template.dart';
import 'package:dota_trivia/data/provider/trivia_provider.dart';
import 'package:dota_trivia/data/ticker/ticker_data.dart';

class TriviaRepository {
  TriviaRepository(this._triviaProvider, this._tickerData);

  final TriviaProvider _triviaProvider;
  final TickerData _tickerData;

  Stream<int> tick(int ticks) => _tickerData.tick(ticks: ticks);

  /// Get a question data
  /// Throws an [TriviaRepositoryException] if question id is null
  /// Returns [QuestionItem] object
  Future<Question> getQuestion() async {
    await _generateQuestion();

    Question question = await _triviaProvider.getLastQuestion();
    if (question.id == null) {
      throw TriviaRepositoryException('Question id is not defined');
    }

    List<Option> options = await _triviaProvider.getOptions(question.id!);
    Template? template;
    if (question.templateId != null) {
      template = await _triviaProvider.getTemplateById(question.templateId!);
    }

    return question.copyWith(options: options, template: template);
  }

  /// Generate a question based on template & save it locally to database
  /// Throws an [TriviaRepositoryException] if template id is not found
  Future<void> _generateQuestion() async {
    Question question;

    List<int> templates = [
      Templates.whatIsTheNameOfThisHero,
      Templates.whatIsTheBaseMovementSpeedFor,
      Templates.whatIsTheBaseAttackFor,
      Templates.whatIsTheBaseArmorFor
    ];
    Template template =
        await _triviaProvider.getTemplateById((templates..shuffle()).first);
    // TemplateItem template =
    //     await _triviaProvider.getTemplateById(Templates.whatIsTheBaseArmorFor);

    switch (template.templateId) {
      case Templates.whatIsTheNameOfThisHero:
        List<Hero> heroes = await _triviaProvider.getRandomHeroesNames(4);
        Hero correctHero = (heroes..shuffle()).first;
        List<String> labels = ['a', 'b', 'c', 'd'];

        question = Question.fromJson({
          'question': template.question,
          'content_url': correctHero.img,
          'template_id': template.id,
          'options': (heroes..shuffle())
              .map((h) => {
                    'label': labels[heroes.indexOf(h)],
                    'content': h.localizedName,
                    'is_correct': correctHero.id == h.id
                  })
              .toList()
        });

        break;
      case Templates.whatIsTheBaseMovementSpeedFor:
        List<int> ms = await _triviaProvider.getRandomHeroesMoveSpeed(4);
        List<Hero> heroes = [];

        for (int m in ms) {
          heroes.add(await _triviaProvider.getRandomHeroByMoveSpeed(m));
        }

        Hero correctHero = (heroes..shuffle()).first;
        List<String> labels = ['a', 'b', 'c', 'd'];

        question = Question.fromJson({
          'question': template.question?.replaceFirst(
              RegExp(r'{replace}'), correctHero.localizedName ?? ''),
          'content_url': correctHero.img,
          'template_id': template.id,
          'options': (heroes..shuffle())
              .map(
                (optHero) => {
                  'label': labels[heroes.indexOf(optHero)],
                  'content': optHero.moveSpeed.toString(),
                  'is_correct': correctHero.id == optHero.id
                },
              )
              .toList()
        });

        break;
      case Templates.whatIsTheBaseAttackFor:
        List<Map<String, int?>> atkdmgs =
            await _triviaProvider.getRandomHeroesAttackDamage(4);
        List<Hero> heroes = [];

        for (var item in atkdmgs) {
          Hero hero = await _triviaProvider.getRandomHeroByAttackDamage(
              item['base_attack_min'] ?? 0, item['base_attack_max'] ?? 0);
          heroes.add(hero);
        }

        Hero correctHero = (heroes..shuffle()).first;
        List<String> labels = ['a', 'b', 'c', 'd'];

        question = Question.fromJson({
          'question': template.question?.replaceFirst(
              RegExp(r'{replace}'), correctHero.localizedName ?? ''),
          'content_url': correctHero.img,
          'template_id': template.id,
          'options': (heroes..shuffle())
              .map(
                (optHero) => {
                  'label': labels[heroes.indexOf(optHero)],
                  'content':
                      '${optHero.getMinAttack()} - ${optHero.getMaxAttack()}',
                  'is_correct': correctHero.id == optHero.id
                },
              )
              .toList()
        });
        break;
      case Templates.whatIsTheBaseArmorFor:
        List<double?> armors = await _triviaProvider.getRandomHeroesArmor(4);
        List<Hero> heroes = [];

        for (double? ar in armors) {
          Hero hero = await _triviaProvider.getRandomHeroByArmor(ar ?? 0.0);
          heroes.add(hero);
        }

        Hero correctHero = (heroes..shuffle()).first;
        List<String> labels = ['a', 'b', 'c', 'd'];

        question = Question.fromJson({
          'question': template.question?.replaceFirst(
              RegExp(r'{replace}'), correctHero.localizedName ?? ''),
          'content_url': correctHero.img,
          'template_id': template.id,
          'options': (heroes..shuffle())
              .map(
                (optHero) => {
                  'label': labels[heroes.indexOf(optHero)],
                  'content': optHero.getArmor(),
                  'is_correct': correctHero.id == optHero.id
                },
              )
              .toList()
        });
        break;
      default:
        throw TriviaRepositoryException('Template undefined');
    }

    int qid = await _triviaProvider.insertQuestion(question);
    await _triviaProvider.insertOptions(question.options ?? [], qid);
  }
}

class TriviaRepositoryException implements Exception {
  TriviaRepositoryException(this.message);
  final String message;
}
