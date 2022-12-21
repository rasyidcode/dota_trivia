import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dota_trivia/data/local/ticker_data.dart';
import 'package:dota_trivia/ui/trivia/cubit/trivia_state.dart';

class TriviaCubit extends Cubit<TriviaState> {
  TriviaCubit(this._ticker) : super(const TriviaState());

  final TickerData _ticker;
  final int _duration = 10;

  StreamSubscription? _streamSubscription;
}
