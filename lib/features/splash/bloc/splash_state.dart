part of 'splash_bloc.dart';

abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {}

// class SplashLoading extends SplashState {
//   const SplashLoading({required String message})
//       : _message = message,
//         super();
//   final String _message;

//   String get message => _message;
// }

class SplashLoading extends SplashState {}

class SplashError extends SplashState {
  const SplashError({required String error})
      : _error = error,
        super();
  final String _error;

  String get error => _error;
}

class SplashSuccess extends SplashState {}
