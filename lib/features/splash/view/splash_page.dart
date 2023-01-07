import 'package:dota_trivia/data/repository/repository.dart';
import 'package:dota_trivia/features/splash/splash.dart';
import 'package:dota_trivia/features/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (_) => SplashBloc(
                dataRepository: RepositoryProvider.of<DataRepository>(context),
              ),
          child: const SplashView()),
    );
  }
}
