import 'package:dota_trivia/features/splash/splash.dart';
import 'package:dota_trivia/features/splash/widget/splash_icon.dart';
import 'package:dota_trivia/features/splash/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    context.read<SplashBloc>().add(SplashDataLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        SplashIcon(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              width: 80,
              child: SplashLoader(),
            ),
          ),
        ),
      ],
    );
  }
}
