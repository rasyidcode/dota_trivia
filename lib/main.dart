import 'package:dota_trivia/app.dart';
import 'package:dota_trivia/data/database/trivia_database.dart';
import 'package:dota_trivia/data/provider/trivia_provider.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:dota_trivia/data/ticker/ticker_data.dart';
import 'package:dota_trivia/dota_trivia_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = DotaTriviaBlocObserver();

  final TriviaDatabase triviaDatabase =
      TriviaDatabase(await getDatabasesPath());
  final TriviaProvider triviaProvider = TriviaProvider(triviaDatabase);
  final TickerData tickerData = TickerData();
  final TriviaRepository triviaRepository =
      TriviaRepository(triviaProvider, tickerData);

  runApp(DotaTriviaApp(
    triviaRepository: triviaRepository,
  ));
}
