// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:dota_trivia/data/repository/trivia_repository.dart';
// import 'package:dota_trivia/data/ticker/ticker_data.dart';
// import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';
// import 'package:flutter/foundation.dart';

// class TriviaCubit extends Cubit<TriviaState> {
//   TriviaCubit(this._triviaRepository, this._tickerData)
//       : super(const TriviaState(status: TriviaStatus.initial));

//   final TriviaRepository _triviaRepository;
//   final TickerData _tickerData;
//   final int _duration = 16;

//   StreamSubscription? _timerStreamSubscription;

//   void chooseOption(String opt) async {
//     emit(state.copyWith(playerOption: opt));
//   }

//   void getQuestion() async {
//     emit(state.copyWith(status: TriviaStatus.loading));

//     try {
//       await _triviaRepository.generateQuestion();
//       final question = await _triviaRepository.getQuestion();

//       emit(state.copyWith(
//         status: TriviaStatus.success,
//         question: question,
//       ));
//     } on Exception catch (e, stacktrace) {
//       if (kDebugMode) {
//         print(stacktrace);
//       }
//       emit(state.copyWith(
//         status: TriviaStatus.error,
//         error: 'Something went wrong',
//       ));
//     }
//   }

//   void _validatePlayerOption() async {
//     await Future.delayed(const Duration(seconds: 2));

//     emit(state.copyWith(status: TriviaStatus.showing));

//     await Future.delayed(const Duration(seconds: 2));

//     emit(state.reset());
//   }

//   void _closeTimer() {
//     _timerStreamSubscription?.cancel();
//   }

//   void toggleTimer() {
//     bool? isPaused = _timerStreamSubscription?.isPaused;
//     if (isPaused != null && isPaused) {
//       _timerStreamSubscription?.resume();
//     } else {
//       _timerStreamSubscription?.pause();
//     }
//   }

//   void _startTrivia() {
//     _closeTimer();

//     _timerStreamSubscription =
//         _tickerData.tick(ticks: _duration).listen((event) async {
//       if (event >= 0) {
//         emit(state.copyWith(status: TriviaStatus.playing, timer: event));

//         if (event == 0) {
//           await Future.delayed(const Duration(seconds: 1));

//           emit(state.copyWith(status: TriviaStatus.checking));
//         }
//       }
//     }, onDone: () => _closeTimer());
//   }

//   @override
//   void onChange(Change<TriviaState> change) {
//     super.onChange(change);

//     if (change.nextState.isReady) {
//       _startTrivia();
//     }

//     if (change.nextState.isChecking) {
//       _validatePlayerOption();
//     }

//     if (change.nextState.isInitial) {
//       getQuestion();
//     }
//   }
// }
