import 'package:dota_trivia/data/repository/data_repository.dart';
import 'package:dota_trivia/ui/splash/cubit/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._dataRepository) : super(const SplashState());

  final DataRepository _dataRepository;
}
