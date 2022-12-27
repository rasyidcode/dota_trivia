import 'dart:async';

import 'package:dota_trivia/data/provider/data_provider.dart';
import 'package:dota_trivia/data/repository/data_repository.dart';
import 'package:dota_trivia/ui/splash/cubit/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._dataRepository)
      : super(const SplashState(fetchDataState: FetchDataState.initial));

  final DataRepository _dataRepository;

  StreamSubscription? _fetchDataStreamSubs;

  void fetchTemplates() async {
    emit(state.copyWith(
        fetchDataState: FetchDataState.loading, message: 'Fetching data...'));

    try {
      _fetchDataStreamSubs =
          _dataRepository.fetchDataStatusStream.listen((msg) {
        emit(state.copyWith(message: msg));
      }, onDone: () {
        emit(state.copyWith(fetchDataState: FetchDataState.success));
      });
    } on DataProviderException catch (e) {
      emit(state.copyWith(
          fetchDataState: FetchDataState.error, message: e.message));
    } on Exception catch (_) {
      emit(state.copyWith(
          fetchDataState: FetchDataState.error,
          message: 'Something went wrong'));
    }
  }

  @override
  void onChange(Change<SplashState> change) {
    super.onChange(change);

    if (change.nextState.isFetchDataFinished) {
      _fetchDataStreamSubs?.cancel();
    }
  }
}
