import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dota_trivia/data/model/question_item.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:equatable/equatable.dart';

part 'trivia_event.dart';
part 'trivia_state.dart';

class TriviaBloc extends Bloc<TriviaEvent, TriviaState> {
  TriviaBloc({required TriviaRepository triviaRepository})
      : _triviaRepository = triviaRepository,
        super(const TriviaInitial()) {
    on<TriviaStarted>(_onStarted);
    on<TriviaAnswered>(_onAnswered);
    on<TriviaFinished>(_onFinished);
  }

  final TriviaRepository _triviaRepository;
  static const int _duration = 10;
  StreamSubscription<int>? _tickerSubscription;

  void _onStarted(TriviaStarted event, Emitter<TriviaState> emit) {
    emit(const TriviaInProgress(
        data: null, timer: _duration, playerAnswer: null));
    _tickerSubscription?.cancel();
    _tickerSubscription = _triviaRepository.tick(event.duration).listen(
        (duration) => emit(TriviaInProgress(
            data: null, timer: event.duration, playerAnswer: null)));
  }

  void _onAnswered(TriviaAnswered event, Emitter<TriviaState> emit) {
    if (state is TriviaInProgress &&
        (state as TriviaInProgress).playerAnswer == null) {
      emit(TriviaInProgress(
          data: state.data,
          timer: (state as TriviaInProgress).timer,
          playerAnswer: event.answer));
    }
  }

  void _onFinished(TriviaFinished event, Emitter<TriviaState> emit) {}
}
