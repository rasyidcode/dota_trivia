import 'package:dota_trivia/data/database/trivia_database.dart';
import 'package:dota_trivia/data/network/trivia_data_source.dart';
import 'package:dota_trivia/data/provider/trivia_provider.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
import 'package:kiwi/kiwi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

Future<void> initKiwi() async {
  String path = await getDatabasesPath();
  KiwiContainer()
    ..registerSingleton((_) => TriviaDatabase(path))
    ..registerInstance(http.Client())
    ..registerFactory((c) => TriviaDataSource(c.resolve()))
    ..registerFactory((c) => TriviaProvider(c.resolve()))
    ..registerFactory((c) => TriviaRepository(c.resolve(), c.resolve()))
    ..registerFactory((c) => TriviaCubit(c.resolve()));
}
