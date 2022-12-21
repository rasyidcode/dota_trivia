import 'package:dota_trivia/ui/trivia/trivia_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DotaTriviaApp());
}

class DotaTriviaApp extends StatelessWidget {
  const DotaTriviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dota Trivia',
      debugShowCheckedModeBanner: false,
      home: TriviaPage(),
    );
  }
}
