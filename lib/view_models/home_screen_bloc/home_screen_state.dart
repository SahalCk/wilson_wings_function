part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

abstract class HomeScreenActionState extends HomeScreenState {}

class AllMoviesFetchedState extends HomeScreenState {
  final List<MovieModel> allMovies;
  AllMoviesFetchedState({required this.allMovies});
}

class MovieFetchingFailedState extends HomeScreenActionState {
  final String error;
  MovieFetchingFailedState({required this.error});
}
