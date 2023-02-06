import 'package:dota_trivia/features/trivia/triva.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionText extends StatelessWidget {
  const QuestionText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TriviaBloc, TriviaState, String?>(
      selector: (state) => state.question?.question,
      builder: (context, question) {
        return Text(
          question ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        );
      },
    );
  }
}
