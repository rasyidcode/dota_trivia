import 'package:dota_trivia/ui/trivia/trivia_page.dart';
import 'package:flutter/material.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('Warning'),
                  icon: Icon(Icons.warning),
                  content: Text(
                    'Feature is not ready yet',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.online_prediction),
          label: Text(
            'PLAY ONLINE',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(letterSpacing: 2.0),
          ),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(180.0),
          ),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton.icon(
          onPressed: () {
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => const TriviaPage()));
          },
          icon: const Icon(Icons.play_arrow),
          label: Text(
            'PLAY',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(letterSpacing: 2.0),
          ),
          style:
              ElevatedButton.styleFrom(fixedSize: const Size.fromWidth(180.0)),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.history),
          label: Text(
            'TRIVIA LOGS',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(letterSpacing: 2.0),
          ),
          style:
              ElevatedButton.styleFrom(fixedSize: const Size.fromWidth(180.0)),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.history),
          label: Text(
            'SYNC DATA',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(letterSpacing: 2.0),
          ),
          style:
              ElevatedButton.styleFrom(fixedSize: const Size.fromWidth(180.0)),
        ),
      ],
    );
  }
}
