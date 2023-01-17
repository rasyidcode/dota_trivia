import 'package:flutter/material.dart';

class QuestionContent extends StatelessWidget {
  const QuestionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/axe.png',
      height: 80.0,
    );
  }
}
