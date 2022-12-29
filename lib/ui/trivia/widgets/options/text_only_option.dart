import 'package:flutter/material.dart';

class TextOnlyOption extends StatelessWidget {
  const TextOnlyOption({super.key, this.content});

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        content != null ? content! : '',
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
