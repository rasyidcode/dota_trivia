part of 'splash_bloc.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class SplashDataLoaded extends SplashEvent {}
