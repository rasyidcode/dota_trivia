part of 'trivia_bloc.dart';

abstract class TriviaState extends Equatable {
  const TriviaState(this.data);

  final QuestionItem? data;

  @override
  List<Object?> get props => [data];
}

class TriviaInitial extends TriviaState {
  const TriviaInitial() : super(null);
}

class TriviaLoading extends TriviaState {
  const TriviaLoading(QuestionItem data) : super(data);
}

class TriviaInProgress extends TriviaState {
  const TriviaInProgress({
    required QuestionItem? data,
    required int timer,
    required String? playerAnswer,
  })  : _timer = timer,
        _playerAnswer = playerAnswer,
        super(data);

  final int _timer;
  final String? _playerAnswer;

  int get timer => _timer;
  String? get playerAnswer => _playerAnswer;
}

class TriviaFinish extends TriviaState {
  const TriviaFinish({
    required QuestionItem data,
    required bool isCorrect,
  })  : _isCorrect = isCorrect,
        super(data);

  final bool _isCorrect;

  bool get isCorrect => _isCorrect;
}

/// States
/// - initial
/// - loading
/// - inprogress
/// - finish