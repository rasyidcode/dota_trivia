import 'package:flutter/material.dart';

class QuestionArea extends StatelessWidget {
  const QuestionArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 130.0,
        child: Column(
          children: [
            Text(
              'What is the base movement speed for Keeper of the Light?',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.red.withRed(255).withGreen(180).withBlue(90),
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Container(
              height: 80.0,
              width: 150.0,
              color: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}
