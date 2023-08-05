import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_in_screen_event.dart';
part 'sign_in_screen_state.dart';

class SignInScreenBloc extends Bloc<SignInScreenEvent, SignInScreenState> {
  SignInScreenBloc() : super(SignInScreenInitial()) {
    on<ObscureValueChangedEvenet>(obscureValueChangedEvenet);
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
  }

  FutureOr<void> obscureValueChangedEvenet(
      ObscureValueChangedEvenet event, Emitter<SignInScreenState> emit) {
    final currentValue = event.currentValue;

    if (currentValue == false) {
      emit(ObscureValueChangedState(obscureValue: true));
    } else {
      emit(ObscureValueChangedState(obscureValue: false));
    }
  }

  FutureOr<void> loginButtonPressedEvent(
      LoginButtonPressedEvent event, Emitter<SignInScreenState> emit) async {
    emit(LoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(error: 'User not Found!'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(error: 'Wrong Password!'));
      } else {
        emit(LoginErrorState(error: e.toString()));
      }
    }
  }
}
