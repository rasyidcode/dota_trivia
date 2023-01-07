import 'dart:async';

import 'package:dota_trivia/data/network/trivia_data_source.dart';
import 'package:dota_trivia/data/provider/data_provider.dart';

class DataRepository {
  DataRepository({
    TriviaDataSource? triviaDataSource,
    required DataProvider dataProvider,
  })  : _triviaDataSource = triviaDataSource ?? TriviaDataSource(),
        _dataProvider = dataProvider;

  final TriviaDataSource _triviaDataSource;
  final DataProvider _dataProvider;

  Future<void> fetchData() async {
    await _fetchTemplates();
    await _fetchHeroes();
    await _fetchItems();
    await _fetchAbilities();
    await Future.delayed(const Duration(seconds: 3));
  }

  /// Fetch templates data from data source and save it locally
  Future<void> _fetchTemplates() async {
    if (!await _dataProvider.isTemplatesDataExist()) {
      final templates = await _triviaDataSource.fetchTemplates();

      await _dataProvider.clearTemplates();

      await _dataProvider.insertTemplates(
        List<Map<String, dynamic>>.from(templates['data']),
      );
    }
  }

  /// Fetch heroes data from data source and save it locally
  Future<void> _fetchHeroes() async {
    if (!await _dataProvider.isHeroesDataExist()) {
      final heroes = await _triviaDataSource.fetchHeroes();
      final abilities = await _triviaDataSource.fetchHeroAbilities();

      await _dataProvider.clearHeroes();

      await _dataProvider.insertHeroes(heroes, abilities);
    }
  }

  /// Fetch items data from data source and save it locally
  Future<void> _fetchItems() async {
    if (!await _dataProvider.isItemsDataExist()) {
      final items = await _triviaDataSource.fetchItems();

      await _dataProvider.clearItems();

      await _dataProvider.insertItems(items);
    }
  }

  /// Fetch abilities from data source and save it locally
  Future<void> _fetchAbilities() async {
    if (!await _dataProvider.isAbilitiesDataExist()) {
      final abilities = await _triviaDataSource.fetchAbilities();

      await _dataProvider.clearAbilities();

      await _dataProvider.insertAbilities(abilities);
    }
  }
}
