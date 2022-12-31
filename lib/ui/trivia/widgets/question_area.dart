import 'package:dota_trivia/constants/apis.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';
import 'package:dota_trivia/ui/trivia/widgets/question_info_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionArea extends StatelessWidget {
  const QuestionArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: BlocSelector<TriviaCubit, TriviaState, String?>(
              selector: (state) => state.question?.question,
              builder: (context, q) => Text(
                q ?? '',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          BlocSelector<TriviaCubit, TriviaState, String?>(
            selector: (state) => state.question?.contentUrl,
            builder: (context, contentUrl) => contentUrl != null
                ? Image.network(
                    '${Apis.steamAssetURL}$contentUrl',
                    height: 80.0,
                  )
                : Container(
                    height: 80.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white54.withOpacity(0.3),
                        width: 1.3,
                      ),
                      gradient: const LinearGradient(
                          colors: [Colors.white12, Colors.white12]),
                    ),
                  ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: BlocSelector<TriviaCubit, TriviaState, String?>(
              selector: (state) => state.question?.template?.info,
              builder: (context, info) {
                print(info);
                return info != null
                    ? QuestionInfoButton(info: info)
                    : const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
