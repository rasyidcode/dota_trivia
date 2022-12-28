import 'package:dota_trivia/data/repository/player_repository.dart';
import 'package:dota_trivia/ui/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._playerRepository)
      : super(const HomeState(getScoreStatus: GetScoreStatus.initial));

  final PlayerRepository _playerRepository;

  void getScore() async {}
}
