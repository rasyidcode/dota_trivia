import 'package:dota_trivia/features/trivia/triva.dart';
import 'package:dota_trivia/features/trivia/widget/option_item.dart';
import 'package:dota_trivia/features/trivia/widget/question_content.dart';
import 'package:dota_trivia/features/trivia/widget/trivia_point.dart';
import 'package:dota_trivia/features/trivia/widget/question_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaView extends StatelessWidget {
  const TriviaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white10,
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DOTA TRIVIA',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(letterSpacing: 2.0),
                ),
                const TriviaPoint()
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white10,
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  QuestionText(),
                  SizedBox(height: 8.0),
                  QuestionContent()
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: ['A', 'B', 'C', 'D'].map((opt) {
              return OptionItem(
                label: opt,
                content: Center(
                    child: Text('Axe',
                        style: Theme.of(context).textTheme.bodyMedium)),
              );
            }).toList(),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white10,
                border:
                    Border.all(color: Theme.of(context).colorScheme.secondary),
              ),
              child: Center(
                child: BlocBuilder<TriviaBloc, TriviaState>(
                  buildWhen: (previous, current) =>
                      previous.runtimeType != current.runtimeType,
                  builder: (context, state) {
                    return Text(
                      '00:00',
                      style: Theme.of(context).textTheme.displayMedium,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
