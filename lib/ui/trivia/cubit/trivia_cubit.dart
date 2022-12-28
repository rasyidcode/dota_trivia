import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dota_trivia/data/provider/trivia_provider.dart';
import 'package:dota_trivia/data/repository/trivia_repository.dart';
import 'package:dota_trivia/data/ticker/ticker_data.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';

class TriviaCubit extends Cubit<TriviaState> {
  TriviaCubit(this._triviaRepository, this._tickerData)
      : super(const TriviaState());

  final TriviaRepository _triviaRepository;
  final TickerData _tickerData;
  final int _duration = 11;

  StreamSubscription? _timerStreamSubscription;

  void generateQuestion() async {
    emit(state);

    await _triviaRepository.generateQuestion();
  }

  void getQuestion() async {
    emit(state);

    await Future.delayed(const Duration(seconds: 2));

    try {
      final question = await _triviaRepository.getQuestion();

      emit(state.copyWith(
        question: question,
      ));
    } on TriviaProviderException catch (e) {
      emit(state.copyWith());
    } on TriviaRepositoryException catch (e) {
      emit(state.copyWith());
    } on Exception catch (_) {
      emit(state.copyWith());
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

    if (change.nextState.isTriviaResetting) {
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
