import 'package:flutter/material.dart';

class TriviaPoint extends StatelessWidget {
  const TriviaPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('POINTS: 1000',
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(letterSpacing: 2.0));
  }
}
