import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dota_trivia/data/network/fetch_data_exception.dart';
import 'package:dota_trivia/data/provider/trivia_provider_exception.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:dota_trivia/data/repository/trivia_repository_exception.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';

class TriviaCubit extends Cubit<TriviaState> {
  TriviaCubit(this._triviaRepository)
      : super(const TriviaState(
            status: TriviaStateStatus.initial, message: 'Initializing...'));

  final TriviaRepository _triviaRepository;
  final int _duration = 11;

  StreamSubscription? _timerStreamSubscription;

  Stream<int> _tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }

  void fetchData() async {
    emit(state.copyWith(fetchDataStatus: FetchDataStatus.loading));

    try {
      await _triviaRepository.fetchData();

      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
          message: 'Fetch data completed',
          fetchDataStatus: FetchDataStatus.success,
          timer: _duration));
    } on FetchDataException catch (e) {
      emit(state.copyWith(
          status: TriviaStateStatus.failure,
          message: e.message,
          fetchDataStatus: FetchDataStatus.failed));
    } on TriviaProviderException catch (e) {
      emit(state.copyWith(
          status: TriviaStateStatus.failure,
          message: e.message,
          fetchDataStatus: FetchDataStatus.failed));
    } on Exception catch (_) {
      emit(state.copyWith(
          status: TriviaStateStatus.failure,
          message: 'Something went wrong',
          fetchDataStatus: FetchDataStatus.failed));
    }
  }

  void getQuestion() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(
      status: TriviaStateStatus.loading,
      message: 'Loading question',
      fetchDataStatus: FetchDataStatus.completed,
    ));

    try {
      await _triviaRepository.generateQuestion();
      final question = await _triviaRepository.getQuestion();

      emit(state.copyWith(
        status: TriviaStateStatus.success,
        message: 'Question loaded',
        question: question,
        sessionStatus: SessionStatus.start,
      ));
    } on TriviaProviderException catch (e) {
      emit(state.copyWith(
          status: TriviaStateStatus.failure, message: e.message));
    } on TriviaRepositoryException catch (e) {
      emit(state.copyWith(
          status: TriviaStateStatus.failure, message: e.message));
    } on Exception catch (_) {
      emit(state.copyWith(
          status: TriviaStateStatus.failure, message: 'Something went wrong'));
    }
  }

  void chooseOption(String opt) async {
    emit(state.copyWith(
      playerOption: opt,
    ));
  }

  void validateOption() async {
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(sessionStatus: SessionStatus.show));

    resetQuestion();
  }

  void resetQuestion() async {
    await Future.delayed(const Duration(seconds: 2));

    emit(state.reset());
  }

  void startTimer() {
    closeTimer();

    _timerStreamSubscription = _tick(ticks: _duration).listen((event) async {
      if (event >= 0) {
        emit(state.copyWith(
            timer: event,
            sessionStatus: SessionStatus.ongoing,
            message: 'Playing'));

        if (event == 0) {
          await Future.delayed(const Duration(seconds: 1));

          emit(state.copyWith(
            sessionStatus: SessionStatus.checking,
            message: 'Checking answer',
          ));
        }
      }
    });
  }

  void closeTimer() {
    _timerStreamSubscription?.cancel();
  }

  @override
  void onChange(Change<TriviaState> change) {
    super.onChange(change);

    if (change.nextState.isReadyStartTrivia) {
      getQuestion();
    }

    if (change.nextState.isTimerReady) {
      startTimer();
    }

    if (change.nextState.isCheckingOption) {
      validateOption();
    }
  }
}
