part of 'sign_up_screen_bloc.dart';

@immutable
abstract class SignUpScreenEvent {}

class SignUpButtonClickedEvent extends SignUpScreenEvent {
  final String email;
  final String password;
  SignUpButtonClickedEvent({required this.email, required this.password});
}
