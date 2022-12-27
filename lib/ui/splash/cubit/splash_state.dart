import 'package:equatable/equatable.dart';

enum FetchDataState { initial, loading, success, error }

class SplashState extends Equatable {
  const SplashState({
    required this.fetchDataState,
    this.message,
  });

  final FetchDataState fetchDataState;
  final String? message;

  bool get isFetchDataSuccess => fetchDataState == FetchDataState.success;
  bool get isFetchDataFinished =>
      fetchDataState == FetchDataState.success ||
      fetchDataState == FetchDataState.error;

  @override
  List<Object?> get props => [fetchDataState, message];

  SplashState copyWith({
    FetchDataState? fetchDataState,
    String? message,
  }) {
    return SplashState(
      fetchDataState: fetchDataState ?? this.fetchDataState,
      message: message ?? this.message,
    );
  }
}
