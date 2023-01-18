part of 'trivia_bloc.dart';

enum AnswerStatus {
  correct,
  incorrect,
  noanswer,
}

abstract class TriviaState extends Equatable {
  const TriviaState(this.question);

  final Question? question;

  @override
  List<Object?> get props => [question];
}

class TriviaInitial extends TriviaState {
  const TriviaInitial() : super(null);
}

class TriviaLoading extends TriviaState {
  const TriviaLoading() : super(null);
}

class TriviaReady extends TriviaState {
  const TriviaReady({
    required Question? question,
    required this.duration,
  }) : super(question);

  final int duration;
}

class TriviaInProgress extends TriviaState {
  const TriviaInProgress({
    required Question? question,
    required this.timer,
    this.playerAnswer,
  }) : super(question);

  final int timer;
  final String? playerAnswer;
}

class TriviaChecking extends TriviaState {
  const TriviaChecking({
    required Question? question,
    this.playerAnswer,
  }) : super(question);

  final String? playerAnswer;
}

class TriviaShowResult extends TriviaState {
  const TriviaShowResult({
    required Question? question,
    required this.status,
  }) : super(question);

  final AnswerStatus status;
}

class TriviaLoadingNextQuestion extends TriviaState {
  const TriviaLoadingNextQuestion({
    required Question? question,
    required this.status,
  }) : super(question);

  final AnswerStatus status;
}

class TriviaError extends TriviaState {
  const TriviaError(this.error) : super(null);

  final String error;
}
