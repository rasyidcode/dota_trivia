import 'package:dota_trivia/data/network/trivia_data_source.dart';
import 'package:dota_trivia/data/provider/data_provider.dart';

class DataRepository {
  DataRepository(this._triviaDataSource, this._dataProvider);

  final TriviaDataSource _triviaDataSource;
  final DataProvider _dataProvider;

  /// Fetch data
  Future<void> fetchData() async {
    final isExistTemplates = await _dataProvider.isTemplatesDataExist();
    final isExistHeroes = await _dataProvider.isHeroesDataExist();

    if (!isExistTemplates) {
      await _fetchTemplates();
    }

    if (!isExistHeroes) {
      await _fetchHeroes();
    }
  }

  /// Fetch template data from data source and save it locally
  Future<void> _fetchTemplates() async {
    final templates = await _triviaDataSource.fetchTemplates();

    // clear templates
    await _dataProvider.clearTemplates();

    await _dataProvider
        .insertTemplates(List<Map<String, dynamic>>.from(templates['data']));
  }

  /// Fetch hero data from data source and save it locally
  Future<void> _fetchHeroes() async {
    final heroes = await _triviaDataSource.fetchHeroes();

    await _dataProvider.clearHeroes();

    await _dataProvider.insertHeroes(heroes);
  }
}
