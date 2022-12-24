import 'package:dota_trivia/constants/apis.dart';
import 'package:dota_trivia/constants/templates.dart';
import 'package:dota_trivia/data/model/common/option_item.dart';
import 'package:dota_trivia/data/model/question_item.dart';
import 'package:dota_trivia/data/network/trivia_data_source.dart';
import 'package:dota_trivia/data/provider/trivia_provider.dart';
import 'package:dota_trivia/data/repository/trivia_repository_exception.dart';

class TriviaRepository {
  TriviaRepository(this._triviaDataSource, this._triviaProvider);

  final TriviaDataSource _triviaDataSource;
  final TriviaProvider _triviaProvider;

  /// Fetch data
  Future<void> fetchData() async {
    final isExistTemplates = await _triviaProvider.isTemplatesDataExist();
    final isExistHeroes = await _triviaProvider.isHeroesDataExist();

    if (!isExistTemplates) {
      await _fetchTemplates();
    }

    if (!isExistHeroes) {
      await _fetchHeroes();
    }
  }

  /// Get a question from database
  ///
  /// Throws an [TriviaRepositoryException] if question id is null
  /// Returns [QuestionItem] object
  Future<QuestionItem> getQuestion() async {
    final question = await _triviaProvider.getLastQuestion();
    if (question.id == null) {
      throw TriviaRepositoryException('Question id is not defined');
    }

    final options = await _triviaProvider.getOptions(question.id!);
    question.options = options;

    return question;
  }

  /// Generate a question based on template & save it locally to database
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
          'image_url': '${Apis.steamAssetURL}/${correctHero.imageUrl}',
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

  /// Fetch template data from data source and save it locally
  Future<void> _fetchTemplates() async {
    final templates = await _triviaDataSource.fetchTemplates();

    // clear templates
    await _triviaProvider.clearTemplates();

    await _triviaProvider
        .insertTemplates(List<Map<String, dynamic>>.from(templates['data']));
  }

  /// Fetch hero data from data source and save it locally
  Future<void> _fetchHeroes() async {
    final heroes = await _triviaDataSource.fetchHeroes();

    await _triviaProvider.clearHeroes();

    await _triviaProvider.insertHeroes(heroes);
  }
}
