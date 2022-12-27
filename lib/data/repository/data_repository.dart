import 'dart:async';

import 'package:dota_trivia/data/network/trivia_data_source.dart';
import 'package:dota_trivia/data/provider/data_provider.dart';

class DataRepository {
  DataRepository(this._triviaDataSource, this._dataProvider);

  final TriviaDataSource _triviaDataSource;
  final DataProvider _dataProvider;

  Stream<String> get fetchDataStatusStream => Stream.fromFutures([
        _fetchTemplates(),
        _fetchHeroes(),
        _fetchItems(),
        _fetchAbilities(),
      ]);

  /// Fetch templates data from data source and save it locally
  Future<String> _fetchTemplates() async {
    final isTemplatesDataExist = await _dataProvider.isTemplatesDataExist();

    if (isTemplatesDataExist) {
      final templates = await _triviaDataSource.fetchTemplates();

      await _dataProvider.clearTemplates();

      await _dataProvider.insertTemplates(
        List<Map<String, dynamic>>.from(templates['data']),
      );
    }

    return 'Templates data loaded';
  }

  /// Fetch heroes data from data source and save it locally
  Future<String> _fetchHeroes() async {
    final isHeroesDataExist = await _dataProvider.isHeroesDataExist();

    if (isHeroesDataExist) {
      final heroes = await _triviaDataSource.fetchHeroes();
      final abilities = await _triviaDataSource.fetchHeroAbilities();

      await _dataProvider.clearHeroes();

      await _dataProvider.insertHeroes(heroes, abilities);
    }

    return 'Heroes data loaded';
  }

  /// Fetch items data from data source and save it locally
  Future<String> _fetchItems() async {
    final isItemsDataExist = await _dataProvider.isItemsDataExist();

    if (isItemsDataExist) {
      final items = await _triviaDataSource.fetchItems();

      await _dataProvider.clearItems();

      await _dataProvider.insertItems(items);
    }

    return 'Items data loaded';
  }

  /// Fetch abilities from data source and save it locally
  Future<String> _fetchAbilities() async {
    final isAbilitiesDataExist = await _dataProvider.isAbilitiesDataExist();

    if (isAbilitiesDataExist) {
      final abilities = await _triviaDataSource.fetchAbilities();

      await _dataProvider.clearAbilities();

      await _dataProvider.insertAbilities(abilities);
    }

    return 'Abilities data loaded';
  }
}
