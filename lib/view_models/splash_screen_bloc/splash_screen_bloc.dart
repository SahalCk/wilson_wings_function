import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<NavigateToLoginScreenEvent>(navigateToLoginScreenEvent);
  }

  FutureOr<void> navigateToLoginScreenEvent(
      NavigateToLoginScreenEvent event, Emitter<SplashScreenState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    emit(NavigateToLoginScreenState());
  }
}
