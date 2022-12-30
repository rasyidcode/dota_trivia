import 'package:flutter/material.dart';

class EmptyOptions extends StatelessWidget {
  const EmptyOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        4,
        (i) => Container(
          width: MediaQuery.of(context).size.width / 2 - (8 * 2 - 4),
          height: 80.0,
          color: Colors.white12,
        ),
      ),
    );
  }
}
