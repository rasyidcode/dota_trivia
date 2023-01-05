import 'package:dota_trivia/constants/colors.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:dota_trivia/trivia/triva.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DotaTriviaApp extends StatelessWidget {
  const DotaTriviaApp({super.key, required TriviaRepository triviaRepository})
      : _triviaRepository = triviaRepository;

  final TriviaRepository _triviaRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _triviaRepository,
      child: const DotaTriviaView(),
    );
  }
}

class DotaTriviaView extends StatelessWidget {
  const DotaTriviaView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dota Trivia',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: kPrimaryColor,
            ),
      ),
      home: const TriviaPage(),
    );
  }
}
