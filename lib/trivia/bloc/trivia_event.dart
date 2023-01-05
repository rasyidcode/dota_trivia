part of 'trivia_bloc.dart';

abstract class TriviaEvent {
  const TriviaEvent();
}

class TriviaStarted extends TriviaEvent {
  const TriviaStarted(this.duration);

  final int duration;
}

class TriviaAnswered extends TriviaEvent {
  const TriviaAnswered(this.answer);

  final String answer;
}

class TriviaFinished extends TriviaEvent {}
