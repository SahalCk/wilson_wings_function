part of 'sign_up_screen_bloc.dart';

@immutable
abstract class SignUpScreenState {}

class SignUpScreenInitial extends SignUpScreenState {}

class SignUpScreenActionState extends SignUpScreenState {}

class LoadingState extends SignUpScreenState {}

class SignUpSuccessState extends SignUpScreenActionState {}

class SignUpFailedState extends SignUpScreenActionState {
  final String error;
  SignUpFailedState({required this.error});
}
