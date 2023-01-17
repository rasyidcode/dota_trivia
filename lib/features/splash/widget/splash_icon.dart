import 'package:flutter/material.dart';

class SplashIcon extends StatelessWidget {
  const SplashIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 2.0,
          ),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: 'DOTA', style: Theme.of(context).textTheme.titleLarge),
            TextSpan(
                text: '\nTRIVIA', style: Theme.of(context).textTheme.titleSmall)
          ]),
        ),
      ),
    );
  }
}
