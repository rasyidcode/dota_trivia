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
                if (state.isLoadingQuestion || state.isCheckingAnswer) {
                  return const TimerLoading();
                } else if (state.isTimerOngoing) {
                  return TimerTicking(
                      seconds: state.timer != null ? state.timer! : 0);
                } else if (state.isShowResult) {
                  return Column(
                    children: [
                      Text(
                        'CORRECT',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.deepOrangeAccent,
                                ),
                      ),
                      Text(
                        '+100 TRIVIA POINTS',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.deepOrangeAccent),
                      ),
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
