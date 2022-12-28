import 'package:equatable/equatable.dart';

enum GetScoreStatus { initial, loading, success, failed }

class HomeState extends Equatable {
  const HomeState({required this.getScoreStatus});

  final GetScoreStatus getScoreStatus;
  @override
  List<Object?> get props => throw UnimplementedError();
}
