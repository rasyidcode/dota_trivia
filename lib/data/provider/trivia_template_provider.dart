import 'package:dota_trivia/data/database/trivia_database.dart';

class TriviaTemplateProvider {
  TriviaTemplateProvider(this._triviaDatabase);

  final TriviaDatabase _triviaDatabase;

  Future<void> insert(Map<String, dynamic> data) async {}
}
