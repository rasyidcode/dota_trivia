import 'package:dota_trivia/ui/splash/cubit/splash_cubit.dart';
import 'package:dota_trivia/ui/splash/cubit/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingStatus extends StatelessWidget {
  const LoadingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SplashCubit, SplashState, String?>(
      selector: (state) => state.message,
      builder: (context, msg) {
        return Text(msg ?? '', style: Theme.of(context).textTheme.labelSmall);
      },
    );
  }
}
