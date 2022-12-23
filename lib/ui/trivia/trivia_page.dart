import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';
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

    _triviaCubit.fetchData();
    _triviaCubit.initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _triviaCubit,
      child: BlocListener<TriviaCubit, TriviaState>(
        listener: (context, state) {
          if (state.isReadyStartTrivia) {
            BlocProvider.of<TriviaCubit>(context).getQuestion();
          }

          if (state.isTimerReady) {
            BlocProvider.of<TriviaCubit>(context).startTimer();
          }

          if (state.isCheckingOption) {
            BlocProvider.of<TriviaCubit>(context).validateOption();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black.withRed(20),
          body: SafeArea(
            child: Column(
              children: [
                const TopBar(),
                const QuestionArea(),
                const SizedBox(height: 8.0),
                const OptionsArea(),
                const SizedBox(height: 8.0),
                const TimerArea(),
                SizedBox(
                  width: double.infinity,
                  child: BlocSelector<TriviaCubit, TriviaState, String?>(
                    selector: (state) => state.message,
                    builder: (context, message) => Text(
                      message ?? 'undefined',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
