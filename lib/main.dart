import 'package:dota_trivia/injection_container.dart';
import 'package:dota_trivia/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initKiwi();

  runApp(const DotaTriviaApp());
}

class DotaTriviaApp extends StatelessWidget {
  const DotaTriviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dota Trivia',
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
