import 'package:dota_trivia/constants/colors.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';
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
      child: BlocListener<TriviaCubit, TriviaState>(
        listener: (context, state) {
          if (state.isError) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                title: Row(
                  children: const [
                    Icon(Icons.error_outline, size: 15.0),
                    SizedBox(width: 8.0),
                    Text('Error')
                  ],
                ),
                titleTextStyle: Theme.of(context).textTheme.labelLarge,
                content: Text(state.error ?? ''),
                contentTextStyle: Theme.of(context).textTheme.labelSmall,
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Close'),
                  )
                ],
              ),
            );
          }
        },
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
      ),
    );
  }
}
