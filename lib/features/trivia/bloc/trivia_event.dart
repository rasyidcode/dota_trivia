part of 'trivia_bloc.dart';

abstract class TriviaEvent {
  const TriviaEvent();
}

class TriviaQuestionLoaded extends TriviaEvent {}

class _TriviaStarted extends TriviaEvent {
  const _TriviaStarted(this.question);

  final QuestionItem question;
}

class TriviaAnswered extends TriviaEvent {
  const TriviaAnswered(this.answer);

  final String answer;
}

class TriviaOptionSelected extends TriviaEvent {
  const TriviaOptionSelected(this.answer);

  final String answer;
}

class TriviaFinished extends TriviaEvent {}
