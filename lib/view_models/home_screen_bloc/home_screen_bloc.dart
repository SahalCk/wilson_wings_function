import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wilson_wings/models/movie_model.dart';
import 'package:wilson_wings/services/api_services.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<GetAllLatestMovies>(getAllLatestMovies);
  }

  FutureOr<void> getAllLatestMovies(
      GetAllLatestMovies event, Emitter<HomeScreenState> emit) async {
    try {
      List<MovieModel> allMovies;
      final response = await APIServices()
          .tmdbGetApi('movie/now_playing?language=en-US&page=1');
      final status = jsonDecode(response.body) as Map<String, dynamic>;
      allMovies = List<MovieModel>.from(status['results'].map((e) {
        MovieModel model = MovieModel.fromJson(e);
        return model;
      }));
      emit(AllMoviesFetchedState(allMovies: allMovies));
    } catch (e) {
      emit(MovieFetchingFailedState(error: e.toString()));
    }
  }
}
