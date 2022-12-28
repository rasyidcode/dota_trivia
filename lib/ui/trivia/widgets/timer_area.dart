import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerArea extends StatelessWidget {
  const TimerArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            BlocBuilder<TriviaCubit, TriviaState>(
              builder: (context, state) {
                String? playerOpt = state.playerOption;
                String? correctOpt = state.correctOption;

                if (state.isLoadingQuestion ||
                    state.isTriviaCheckingPlayerOption) {
                  return const TimerLoading();
                } else if (state.isTriviaOngoing) {
                  return TimerTicking(
                      seconds: state.timer != null ? state.timer! : 0);
                } else if (state.isTriviaShowingResult) {
                  if (playerOpt == null) {
                    return const NoAnswerSubmitted();
                  }
                  String result = 'INCORRECT';
                  bool isCorrect = false;

                  if (correctOpt != null) {
                    isCorrect = playerOpt == correctOpt;
                    result = isCorrect ? 'CORRECT' : 'INCORRECT';
                  }

                  return Column(
                    children: [
                      Text(
                        result,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.deepOrangeAccent,
                                ),
                      ),
                      isCorrect
                          ? Text(
                              '+100 TRIVIA POINTS',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.deepOrangeAccent),
                            )
                          : Container(),
                    ],
                  );
                }

                return Container();
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class TimerLoading extends StatelessWidget {
  const TimerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.white,
    );
  }
}

class NoAnswerSubmitted extends StatelessWidget {
  const NoAnswerSubmitted({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'NO ANSWER SUBMITTED',
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: Colors.white60),
    );
  }
}

class TimerTicking extends StatelessWidget {
  const TimerTicking({super.key, required this.seconds});

  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
