import 'package:flutter/material.dart';

class QuestionText extends StatelessWidget {
  const QuestionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'What is the name of this hero?',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
