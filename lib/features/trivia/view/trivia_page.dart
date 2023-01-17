import 'package:dota_trivia/data/repository/repository.dart';
import 'package:dota_trivia/features/trivia/triva.dart';
import 'package:dota_trivia/features/trivia/view/trivia_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaPage extends StatelessWidget {
  const TriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TriviaBloc(
          triviaRepository: RepositoryProvider.of<TriviaRepository>(context)),
      child: const Scaffold(
        body: SafeArea(child: TriviaView()),
      ),
    );
  }
}
