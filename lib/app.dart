import 'package:dota_trivia/data/repository/data_repository.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:dota_trivia/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DotaTriviaApp extends StatelessWidget {
  const DotaTriviaApp({
    super.key,
    required TriviaRepository triviaRepository,
    required DataRepository dataRepository,
  })  : _triviaRepository = triviaRepository,
        _dataRepository = dataRepository;

  final TriviaRepository _triviaRepository;
  final DataRepository _dataRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _triviaRepository),
        RepositoryProvider.value(value: _dataRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => SplashBloc(
                  dataRepository:
                      RepositoryProvider.of<DataRepository>(context))),
          // BlocProvider<TriviaBloc>(
          //   create: (_) => TriviaBloc(
          //     triviaRepository:
          //         RepositoryProvider.of<TriviaRepository>(context),
          //   ),
          // ),
        ],
        child: const DotaTriviaView(),
      ),
    );
  }
}

class DotaTriviaView extends StatelessWidget {
  const DotaTriviaView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dota Trivia',
      home: SplashPage(),
    );
  }
}
