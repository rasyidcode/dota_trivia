import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dota_trivia/data/model/question_item.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:dota_trivia/features/trivia/triva.dart';
import 'package:equatable/equatable.dart';

part 'trivia_event.dart';
part 'trivia_state.dart';

class TriviaBloc extends Bloc<TriviaEvent, TriviaState> {
  TriviaBloc({required TriviaRepository triviaRepository})
      : _triviaRepository = triviaRepository,
        super(const TriviaInitial()) {
    on<TriviaQuestionLoaded>(_onQuestionLoaded);
    on<_TriviaStarted>(_onStarted);
    on<TriviaAnswered>(_onAnswered);
    on<TriviaFinished>(_onFinished);
  }

  final TriviaRepository _triviaRepository;
  static const int _duration = 10;
  StreamSubscription<int>? _tickerSubscription;

  void _onQuestionLoaded(
      TriviaQuestionLoaded event, Emitter<TriviaState> emit) async {
    emit(const TriviaLoading(null));

    try {
      final question = await _triviaRepository.getQuestion();

      add(_TriviaStarted(question));
    } on Exception catch (_) {
      emit(const TriviaError('Something went wrong'));
    }
  }

  void _onStarted(_TriviaStarted event, Emitter<TriviaState> emit) {
    emit(TriviaInProgress(
      data: event.question,
      timer: _duration,
      playerAnswer: null,
    ));

    _tickerSubscription?.cancel();
    _tickerSubscription = _triviaRepository.tick(_duration).listen(
          (dur) => emit(dur > 0
              ? TriviaInProgress(
                  data: event.question,
                  timer: dur,
                  playerAnswer: null,
                )
              : TriviaChecking(event.question)),
        );
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
