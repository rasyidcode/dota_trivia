import 'dart:convert';

import 'package:dota_trivia/constants/apis.dart';
import 'package:http/http.dart' as http;

class TriviaDataSource {
  TriviaDataSource({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<Map<String, dynamic>> fetchTemplates() async {
    final response = await _client
        .get(Uri.parse('${Apis.rasyidcodeGithubURL}/trivia_templates.json'));
    if (response.statusCode != 200) {
      throw FetchDataException();
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> fetchHeroes() async {
    final response =
        await _client.get(Uri.parse('${Apis.odotaGithubURL}/heroes.json'));
    if (response.statusCode != 200) {
      throw FetchDataException();
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> fetchItems() async {
    final response =
        await _client.get(Uri.parse('${Apis.odotaGithubURL}/items.json'));
    if (response.statusCode != 200) {
      throw FetchDataException();
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> fetchHeroAbilities() async {
    final response = await _client
        .get(Uri.parse('${Apis.odotaGithubURL}/hero_abilities.json'));
    if (response.statusCode != 200) {
      throw FetchDataException();
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> fetchAbilities() async {
    final response =
        await _client.get(Uri.parse('${Apis.odotaGithubURL}/abilities.json'));
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
