import 'package:dota_trivia/data/network/dota_trivia_asset.dart';

class TriviaRepository {
  TriviaRepository(this._dotaTriviaAsset);

  final DotaTriviaAsset _dotaTriviaAsset;

  // todo: fetch trivia template
  Future<void> fetchTriviaTemplate() async {
    final template = await _dotaTriviaAsset.fetchTriviaTemplates();

    // await
  }

  // todo: fetch heroes

  // todo: get question
}
