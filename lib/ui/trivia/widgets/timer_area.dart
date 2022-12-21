import 'package:flutter/material.dart';

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
            Text(
              'NO ANSWER SUBMITTED',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white60),
            ),
            Column(
              children: [
                Text(
                  '00:10',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color:
                            Colors.red.withRed(255).withGreen(140).withBlue(80),
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
            ),
            Text(
              'INCORRECT',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.red.withRed(255).withGreen(140).withBlue(80),
                  ),
            ),
            Column(
              children: [
                Text(
                  'CORRECT',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color:
                            Colors.red.withRed(255).withGreen(140).withBlue(80),
                      ),
                ),
                Text(
                  '+100 TRIVIA POINTS',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color:
                          Colors.red.withRed(255).withGreen(140).withBlue(80)),
                ),
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
