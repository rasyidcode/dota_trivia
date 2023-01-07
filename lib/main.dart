import 'package:dota_trivia/app.dart';
import 'package:dota_trivia/data/database/trivia_database.dart';
import 'package:dota_trivia/data/provider/data_provider.dart';
import 'package:dota_trivia/data/provider/trivia_provider.dart';
import 'package:dota_trivia/data/repository/data_repository.dart';
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

  final TriviaRepository triviaRepository =
      TriviaRepository(TriviaProvider(triviaDatabase), TickerData());
  final DataRepository dataRepository =
      DataRepository(dataProvider: DataProvider(triviaDatabase));

  runApp(DotaTriviaApp(
    triviaRepository: triviaRepository,
    dataRepository: dataRepository,
  ));
}
