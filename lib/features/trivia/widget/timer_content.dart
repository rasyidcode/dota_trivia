import 'package:dota_trivia/features/trivia/triva.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerContent extends StatelessWidget {
  const TimerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TriviaBloc, TriviaState>(
      listenWhen: (previous, current) => current is TriviaReady,
      listener: (context, state) {
        if (state is TriviaReady) {
          BlocProvider.of<TriviaBloc>(context).add(TriviaStarted(
              question: state.question, duration: state.duration));
        }
      },
      // buildWhen: (previous, current) =>
      //     previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return Column(
          children: [
            if (state is TriviaLoading) ...[const CircularProgressIndicator()],
            if (state is TriviaInProgress) ...[
              Text(
                '00:${seconds.toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.deepOrangeAccent,
                    ),
              ),
              Text(
                'TIME REMAINING',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
            ]
          ],
        );
      },
    );
  }
}
