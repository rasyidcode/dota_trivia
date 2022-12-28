import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          onPressed: () {
            print('click');
          },
          icon: const Icon(Icons.info),
        ),
        IconButton(
          onPressed: () {
            print('click');
          },
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
