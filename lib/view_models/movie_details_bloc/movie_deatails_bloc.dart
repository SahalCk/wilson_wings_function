import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wilson_wings/services/api_services.dart';

part 'movie_deatails_event.dart';
part 'movie_deatails_state.dart';

class MovieDeatailsBloc extends Bloc<MovieDeatailsEvent, MovieDeatailsState> {
  MovieDeatailsBloc() : super(MovieDeatailsInitial()) {
    on<BookMovieButtonClickedEvent>(bookMovieButtonClickedEvent);
  }

  FutureOr<void> bookMovieButtonClickedEvent(BookMovieButtonClickedEvent event,
      Emitter<MovieDeatailsState> emit) async {
    final response = await APIServices().jsonPostApi('posts');
    final statusCode = response.statusCode;
    if (statusCode == 200 || statusCode == 201) {
      emit(MovieBookedState());
    } else {
      emit(MovieBookedFailedState());
    }
  }
}
