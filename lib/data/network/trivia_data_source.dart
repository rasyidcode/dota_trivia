import 'dart:convert';

import 'package:dota_trivia/constants/apis.dart';
import 'package:dota_trivia/data/network/fetch_data_exception.dart';
import 'package:http/http.dart' as http;

class TriviaDataSource {
  TriviaDataSource(this.client);

  final http.Client client;

  Future<Map<String, dynamic>> fetchTemplates() async {
    final response = await client
        .get(Uri.parse('${Apis.rasyidcodeGithubURL}/trivia_templates.json'));
    if (response.statusCode != 200) {
      throw FetchDataException();
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> fetchHeroes() async {
    final response =
        await client.get(Uri.parse('${Apis.odotaGithubURL}/heroes.json'));
    if (response.statusCode != 200) {
      throw FetchDataException();
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
