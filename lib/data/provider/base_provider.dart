import 'package:dota_trivia/data/database/trivia_database.dart';

abstract class BaseProvider {
  BaseProvider(this._triviaDatabase);

  final TriviaDatabase _triviaDatabase;

  Future<void> clearData({required String table}) async =>
      await (await _triviaDatabase.db)?.rawDelete('DELETE FROM $table');
}

class BaseProviderException implements Exception {
  BaseProviderException(this.message);

  final String message;
}
