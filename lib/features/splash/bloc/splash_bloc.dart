import 'package:bloc/bloc.dart';
import 'package:dota_trivia/data/repository/data_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required DataRepository dataRepository})
      : _dataRepository = dataRepository,
        super(SplashInitial()) {
    on<SplashDataLoaded>(_onLoaded);
  }

  final DataRepository _dataRepository;

  void _onLoaded(SplashDataLoaded event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    try {
      await _dataRepository.fetchData();

      emit(SplashSuccess());
    } on Exception catch (_) {
      emit(const SplashError(error: 'Something went wrong'));
    }
  }
}
