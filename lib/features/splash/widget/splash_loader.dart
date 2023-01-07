import 'dart:async';

import 'package:dota_trivia/features/menu/view/menu_page.dart';
import 'package:dota_trivia/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashLoader extends StatelessWidget {
  const SplashLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listenWhen: (previous, current) =>
          current is SplashSuccess || current is SplashError,
      listener: (context, state) {
        if (state is SplashSuccess) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MenuPage()));
        }

        if (state is SplashError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));

          Timer(
              const Duration(seconds: 2),
              () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MenuPage())));
        }
      },
      buildWhen: (previous, current) => current is SplashLoading,
      builder: (context, state) {
        if (state is SplashLoading) {
          return const LinearProgressIndicator();
        }

        return Container();
      },
    );
  }
}
