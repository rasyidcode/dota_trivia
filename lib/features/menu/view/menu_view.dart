import 'package:dota_trivia/features/trivia/triva.dart';
import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.info)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.white10,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary)),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'HIGH SCORE',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w300)),
                        TextSpan(
                            text: '\n2000',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ])),
                )
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const TriviaPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white24,
                    fixedSize: const Size(160, 40),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  icon: const Icon(Icons.send_sharp, size: 16.0),
                  label: Text(
                    'START',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 2.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12.0),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white24,
                    fixedSize: const Size(160, 40),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  icon: const Icon(Icons.replay, size: 16.0),
                  label: Text(
                    'TRIVIA LOG',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 2.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12.0),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white24,
                    fixedSize: const Size(160, 40),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  icon: const Icon(Icons.book, size: 16.0),
                  label: Text(
                    'WIKI',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 2.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
