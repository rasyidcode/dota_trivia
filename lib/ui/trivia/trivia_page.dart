import 'package:dota_trivia/constants/colors.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
import 'package:dota_trivia/ui/trivia/widgets/info_bar.dart';
import 'package:dota_trivia/ui/trivia/widgets/options_area.dart';
import 'package:dota_trivia/ui/trivia/widgets/question_area.dart';
import 'package:dota_trivia/ui/trivia/widgets/timer_area.dart';
import 'package:dota_trivia/ui/trivia/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

class TriviaPage extends StatefulWidget {
  const TriviaPage({super.key});

  @override
  State<TriviaPage> createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {
  final _triviaCubit = KiwiContainer().resolve<TriviaCubit>();

  @override
  void initState() {
    super.initState();

    _triviaCubit.getQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _triviaCubit,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Column(
            children: const [
              TopBar(),
              QuestionArea(),
              SizedBox(height: 8.0),
              OptionsArea(),
              SizedBox(height: 8.0),
              TimerArea(),
              InfoBar()
            ],
          ),
        ),
      ),
    );
  }
}
