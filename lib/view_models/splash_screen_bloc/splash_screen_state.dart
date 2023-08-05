part of 'splash_screen_bloc.dart';

@immutable
abstract class SplashScreenState {}

class SplashScreenInitial extends SplashScreenState {}

abstract class SplashScreenActionState extends SplashScreenState {}

class NavigateToLoginScreenState extends SplashScreenActionState {}
