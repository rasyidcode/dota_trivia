import 'package:dota_trivia/constants/apis.dart';
import 'package:dota_trivia/constants/templates.dart';
import 'package:dota_trivia/data/model/common/option_item.dart';
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
    final question = await _triviaProvider.getLastQuestion();
    if (question.id == null) {
      throw TriviaRepositoryException('Question id is not defined');
    }

    final options = await _triviaProvider.getOptions(question.id!);
    TemplateItem? template;
    if (question.templateId != null) {
      template = await _triviaProvider.getTemplateById(question.templateId!);
    }

    return question.copyWith(options: options, templateItem: template);
  }

  /// Generate a question based on template & save it locally to database
  /// Throws an [TriviaRepositoryException] if template id is not found
  Future<void> generateQuestion() async {
    final QuestionItem question;
    final List<OptionItem> options;

    final template = await _triviaProvider
        .getTemplateById(Templates.whatIsTheNameOfThisHero);

    switch (template.id) {
      case Templates.whatIsTheNameOfThisHero:
        final heroes = (await _triviaProvider.getHeroes()
          ..shuffle());
        final optHeroes = heroes.take(4).toList();
        final correctHero = (optHeroes..shuffle()).first;
        final labels = ['a', 'b', 'c', 'd'];

        question = QuestionItem.fromJson({
          'question': template.question,
          'content_url': '${Apis.steamAssetURL}/${correctHero.img}',
          'template_id': template.id,
        });
        options = (optHeroes..shuffle())
            .map(
              (optHero) => OptionItem.fromJson({
                'label': labels[optHeroes.indexOf(optHero)],
                'content': optHero.name,
                'is_correct': correctHero.id == optHero.id
              }),
            )
            .toList();
        break;
      default:
        throw TriviaRepositoryException('Template undefined');
    }

    int qid = await _triviaProvider.insertQuestion(question);
    await _triviaProvider.insertOptions(options, qid);
  }
}

class TriviaRepositoryException implements Exception {
  TriviaRepositoryException(this.message);
  final String message;
}
