import 'package:dota_trivia/constants/templates.dart';
import 'package:dota_trivia/data/model/common/option_item.dart';
import 'package:dota_trivia/data/model/hero_item.dart';
import 'package:dota_trivia/data/model/question_item.dart';
import 'package:dota_trivia/data/model/template_item.dart';
import 'package:dota_trivia/data/provider/trivia_provider.dart';

class TriviaRepository {
  TriviaRepository(this._triviaProvider);

  final TriviaProvider _triviaProvider;

  /// Get a question data
  /// Throws an [TriviaRepositoryException] if question id is null
  /// Returns [QuestionItem] object
  Future<QuestionItem> getQuestion() async {
    QuestionItem question = await _triviaProvider.getLastQuestion();
    if (question.id == null) {
      throw TriviaRepositoryException('Question id is not defined');
    }

    List<OptionItem> options = await _triviaProvider.getOptions(question.id!);
    TemplateItem? template;
    if (question.templateId != null) {
      template = await _triviaProvider.getTemplateById(question.templateId!);
    }

    return question.copyWith(options: options, template: template);
  }

  /// Generate a question based on template & save it locally to database
  /// Throws an [TriviaRepositoryException] if template id is not found
  Future<void> generateQuestion() async {
    QuestionItem question;

    TemplateItem template = await _triviaProvider
        .getTemplateById(Templates.whatIsTheNameOfThisHero);

    switch (template.templateId) {
      case Templates.whatIsTheNameOfThisHero:
        List<HeroItem> heroes = await _triviaProvider.getRandomHeroes(4);
        HeroItem correctHero = (heroes..shuffle()).first;
        List<String> labels = ['a', 'b', 'c', 'd'];

        question = QuestionItem.fromJson({
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
        List<HeroItem> heroes = await _triviaProvider.getRandomHeroes(4);
        HeroItem correctOpt = (heroes..shuffle()).first;
        List<String> labels = ['a', 'b', 'c', 'd'];

        question = QuestionItem.fromJson({
          'question': template.question?.replaceFirst(
              RegExp(r'{replace}'), correctOpt.localizedName ?? ''),
          'content_url': correctOpt.img,
          'template_id': template.id,
          'options': (heroes..shuffle())
              .map(
                (optHero) => OptionItem.fromJson({
                  'label': labels[heroes.indexOf(optHero)],
                  'content': optHero.moveSpeed.toString(),
                  'is_correct': correctOpt.id == optHero.id
                }),
              )
              .toList()
        });
        break;
      case Templates.whatIsTheBaseAttackFor:
        List<HeroItem> heroes = await _triviaProvider.getRandomHeroes(4);
        HeroItem correctOpt = (heroes..shuffle()).first;
        List<String> labels = ['a', 'b', 'c', 'd'];

        question = QuestionItem.fromJson({
          'question': template.question?.replaceFirst(
              RegExp(r'{replace}'), correctOpt.localizedName ?? ''),
          'content_url': correctOpt.img,
          'template_id': template.id,
          'options': (heroes..shuffle())
              .map(
                (optHero) => OptionItem.fromJson({
                  'label': labels[heroes.indexOf(optHero)],
                  'content':
                      '${optHero.getMinAttack()} - ${optHero.getMaxAttack()}',
                  'is_correct': correctOpt.id == optHero.id
                }),
              )
              .toList()
        });
        break;
      case Templates.whatIsTheBaseArmorFor:
        final heroes = await _triviaProvider.getRandomHeroes(4);
        final correctOpt = (heroes..shuffle()).first;
        final labels = ['a', 'b', 'c', 'd'];

        question = QuestionItem.fromJson({
          'question': template.question?.replaceFirst(
              RegExp(r'{replace}'), correctOpt.localizedName ?? ''),
          'content_url': correctOpt.img,
          'template_id': template.id
        });
        question.copyWith(
            options: (heroes..shuffle())
                .map(
                  (optHero) => OptionItem.fromJson({
                    'label': labels[heroes.indexOf(optHero)],
                    'content': optHero.getArmor(),
                    'is_correct': correctOpt.id == optHero.id
                  }),
                )
                .toList());
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
