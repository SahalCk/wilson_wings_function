part of 'sign_in_screen_bloc.dart';

@immutable
abstract class SignInScreenEvent {}

class ObscureValueChangedEvenet extends SignInScreenEvent {
  final bool currentValue;

  ObscureValueChangedEvenet({required this.currentValue});
}

class LoginButtonPressedEvent extends SignInScreenEvent {
  final String email;
  final String password;

  LoginButtonPressedEvent({required this.email, required this.password});
}
