part of 'trivia_bloc.dart';

abstract class TriviaEvent {
  const TriviaEvent();
}

class TriviaQuestionLoaded extends TriviaEvent {}

class TriviaStarted extends TriviaEvent {
  const TriviaStarted({
    required this.question,
    required this.duration,
  });

  final Question question;
  final int duration;
}

class TriviaAnswered extends TriviaEvent {
  const TriviaAnswered(this.answer);

  final String answer;
}

class TriviaChecked extends TriviaEvent {}

class TriviaResultShowed extends TriviaEvent {}

class TriviaNextQuestionLoaded extends TriviaEvent {}
