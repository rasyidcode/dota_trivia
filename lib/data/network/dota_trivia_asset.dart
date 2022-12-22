import 'dart:convert';

import 'package:http/http.dart' as http;

class DotaTriviaAsset {
  DotaTriviaAsset(this.client);

  static const baseURL =
      'https://raw.githubusercontent.com/rasyidcode/dota_trivia/main/assets/';

  final http.Client client;

  Future<Map<String, dynamic>> fetchTriviaTemplates() async {
    final response =
        await client.get(Uri.parse('$baseURL/trivia_templates.json'));
    if (response.statusCode != 200) {
      throw FetchDataException();
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}

class FetchDataException implements Exception {
  FetchDataException();
  final message = 'Error fetching data';
}
