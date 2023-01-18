import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dota_trivia/data/model/question.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:equatable/equatable.dart';

part 'trivia_event.dart';
part 'trivia_state.dart';

class TriviaBloc extends Bloc<TriviaEvent, TriviaState> {
  TriviaBloc({required TriviaRepository triviaRepository})
      : _triviaRepository = triviaRepository,
        super(const TriviaInitial()) {
    on<TriviaQuestionLoaded>(_onQuestionLoaded);
    on<TriviaStarted>(_onStarted);
    on<TriviaAnswered>(_onAnswered);
    on<TriviaChecked>(_onChecked);
    on<TriviaResultShowed>(_onResultShowed);
    on<TriviaNextQuestionLoaded>(_onNextQuestionLoaded);
  }

  final TriviaRepository _triviaRepository;
  static const int _duration = 10;
  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onQuestionLoaded(
      TriviaQuestionLoaded event, Emitter<TriviaState> emit) async {
    emit(const TriviaLoading());

    try {
      final question = await _triviaRepository.getQuestion();

      emit(TriviaReady(question: question, duration: _duration));
    } on Exception catch (_) {
      emit(const TriviaError('Something went wrong'));
    }
  }

  void _onStarted(TriviaStarted event, Emitter<TriviaState> emit) {
    emit(TriviaInProgress(
      question: event.question,
      timer: event.duration,
      playerAnswer: null,
    ));

    _tickerSubscription?.cancel();
    _tickerSubscription = _triviaRepository.tick(event.duration).listen(
          (tick) => emit(TriviaInProgress(
            question: event.question,
            timer: tick,
            playerAnswer: (state as TriviaInProgress).playerAnswer,
          )),
        );
  }

  void _onAnswered(TriviaAnswered event, Emitter<TriviaState> emit) {
    if (state is TriviaInProgress &&
        (state as TriviaInProgress).playerAnswer == null) {
      emit(TriviaInProgress(
          question: state.question,
          timer: (state as TriviaInProgress).timer,
          playerAnswer: event.answer));
    }
  }

  void _onChecked(TriviaChecked event, Emitter<TriviaState> emit) {
    if (state is TriviaInProgress && (state as TriviaInProgress).timer == 0) {
      emit(TriviaChecking(
        question: (state as TriviaInProgress).question,
        playerAnswer: (state as TriviaInProgress).playerAnswer,
      ));
    }
  }

  void _onResultShowed(TriviaResultShowed event, Emitter<TriviaState> emit) {
    if (state is TriviaChecking) {
      String? label = state.question?.options
          ?.firstWhere((opt) => opt.isCorrect == true)
          .label;
      String? playerAnswer = (state as TriviaInProgress).playerAnswer;
      AnswerStatus status;

      if (playerAnswer != null) {
        if (playerAnswer == label) {
          status = AnswerStatus.correct;
        } else {
          status = AnswerStatus.incorrect;
        }
      } else {
        status = AnswerStatus.noanswer;
      }

      emit(
        TriviaShowResult(
          question: state.question,
          status: status,
        ),
      );
    }
  }

  void _onNextQuestionLoaded(
      TriviaNextQuestionLoaded event, Emitter<TriviaState> emit) async {
    if (state is TriviaShowResult) {
      emit(TriviaLoadingNextQuestion(
          question: state.question,
          status: (state as TriviaShowResult).status));

      try {
        final question = await _triviaRepository.getQuestion();

        emit(TriviaReady(question: question, duration: _duration));
      } on Exception catch (_) {
        emit(const TriviaError('Something went wrong'));
      }
    }
  }
}
