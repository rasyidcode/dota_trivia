import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dota_trivia/data/provider/trivia_provider.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:dota_trivia/data/ticker/ticker_data.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';

class TriviaCubit extends Cubit<TriviaState> {
  TriviaCubit(this._triviaRepository, this._tickerData)
      : super(const TriviaState()) {
    emit(
        state.copyWith(generateQuestionStatus: GenerateQuestionStatus.loading));
  }

  final TriviaRepository _triviaRepository;
  final TickerData _tickerData;
  final int _duration = 11;

  StreamSubscription? _timerStreamSubscription;

  void generateQuestion() async {
    try {
      await _triviaRepository.generateQuestion();

      emit(state.copyWith(
        generateQuestionStatus: GenerateQuestionStatus.success,
      ));
    } on TriviaProviderException catch (e) {
      emit(state.copyWith(
          generateQuestionStatus: GenerateQuestionStatus.error,
          error: e.message));
    } on TriviaRepositoryException catch (e) {
      emit(state.copyWith(
          generateQuestionStatus: GenerateQuestionStatus.error,
          error: e.message));
    } on Exception catch (_) {
      emit(state.copyWith(
          generateQuestionStatus: GenerateQuestionStatus.error,
          error: 'Something went worng'));
    }
  }

  void getQuestion() async {
    emit(state.copyWith(getQuestionStatus: GetQuestionStatus.loading));

    try {
      final question = await _triviaRepository.getQuestion();

      emit(state.copyWith(
        getQuestionStatus: GetQuestionStatus.success,
        question: question,
      ));
    } on TriviaProviderException catch (e) {
      emit(state.copyWith(
          generateQuestionStatus: GenerateQuestionStatus.error,
          error: e.message));
    } on TriviaRepositoryException catch (e) {
      emit(state.copyWith(
          generateQuestionStatus: GenerateQuestionStatus.error,
          error: e.message));
    } on Exception catch (_) {
      emit(state.copyWith(
          generateQuestionStatus: GenerateQuestionStatus.error,
          error: 'Something went wrong'));
    }
  }

  void chooseOption(String opt) async {
    emit(state.copyWith(
      playerOption: opt,
    ));
  }

  void validateOption() async {
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith());

    resetQuestion();
  }

  void resetQuestion() async {
    await Future.delayed(const Duration(seconds: 2));

    emit(state);
  }

  void startTimer() {
    closeTimer();

    _timerStreamSubscription =
        _tickerData.tick(ticks: _duration).listen((event) async {
      if (event >= 0) {
        emit(state.copyWith(timer: event));

        if (event == 0) {
          await Future.delayed(const Duration(seconds: 1));

          emit(state.copyWith());
        }
      }
    }, onDone: () => closeTimer());
  }

  void closeTimer() {
    _timerStreamSubscription?.cancel();
  }

  @override
  void onChange(Change<TriviaState> change) {
    super.onChange(change);

    if ((change.currentState.isGenerateQuestionInitial &&
            change.nextState.isGenerateQuestionLoading) ||
        change.nextState.isTriviaShowingResult) {
      generateQuestion();
    }

    if (change.nextState.isGenerateQuestionSuccess ||
        change.nextState.isTriviaResetting) {
      getQuestion();
    }

    if (change.nextState.isTriviaReady) {
      startTimer();
    }

    if (change.nextState.isTriviaCheckingPlayerOption) {
      validateOption();
    }
  }
}
