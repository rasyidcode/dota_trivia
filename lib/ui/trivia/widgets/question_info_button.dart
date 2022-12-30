import 'package:dota_trivia/ui/trivia/cubit/trivia_cubit.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionInfoButton extends StatelessWidget {
  const QuestionInfoButton({super.key, required this.info});

  final String info;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.info, size: 15.0),
                SizedBox(width: 8.0),
                Text('About Question')
              ],
            ),
            titleTextStyle: Theme.of(context).textTheme.labelLarge,
            content: Text(info),
            contentTextStyle: Theme.of(context).textTheme.labelSmall,
          ),
        );
      },
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.info,
        color: Colors.white54,
      ),
      iconSize: 15.0,
      splashRadius: 15.0,
      constraints: const BoxConstraints(),
    );
  }
}
