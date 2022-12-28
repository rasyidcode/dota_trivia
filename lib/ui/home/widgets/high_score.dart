import 'package:dota_trivia/constants/colors.dart';
import 'package:flutter/material.dart';

class HighScore extends StatelessWidget {
  const HighScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'HIGH SCORE',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(letterSpacing: 2.0, color: kPrimaryColor),
        ),
        Text(
          '3900',
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }
}
