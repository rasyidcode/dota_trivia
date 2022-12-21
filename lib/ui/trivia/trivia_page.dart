import 'package:dota_trivia/ui/trivia/widgets/options_area.dart';
import 'package:dota_trivia/ui/trivia/widgets/question_area.dart';
import 'package:dota_trivia/ui/trivia/widgets/timer_area.dart';
import 'package:dota_trivia/ui/trivia/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class TriviaPage extends StatefulWidget {
  const TriviaPage({super.key});

  @override
  State<TriviaPage> createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.withRed(130).withOpacity(0.6),
      body: SafeArea(
        child: Column(
          children: const [
            TopBar(),
            QuestionArea(),
            SizedBox(height: 8.0),
            OptionsArea(),
            SizedBox(height: 8.0),
            TimerArea()
          ],
        ),
      ),
    );
  }
}
