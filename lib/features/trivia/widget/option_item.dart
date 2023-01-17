import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({super.key, required this.label, required this.content});

  final String label;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white10,
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      width: MediaQuery.of(context).size.width / 2 - (8 * 2 - 4),
      height: 80.0,
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          content,
          // Align(alignment: Alignment.bottomRight, child: Icon(Icons.close))
        ],
      ),
    );
  }
}
