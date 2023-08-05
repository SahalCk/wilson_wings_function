part of 'sign_in_screen_bloc.dart';

@immutable
abstract class SignInScreenState {}

class SignInScreenInitial extends SignInScreenState {}

class SignInScreenActionState extends SignInScreenState {}

class ObscureValueChangedState extends SignInScreenState {
  final bool obscureValue;

  ObscureValueChangedState({required this.obscureValue});
}

class LoginErrorState extends SignInScreenActionState {
  final String error;
  LoginErrorState({required this.error});
}

class LoginSuccessState extends SignInScreenActionState {}

class LoadingState extends SignInScreenState {}
