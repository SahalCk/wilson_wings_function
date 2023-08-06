part of 'movie_deatails_bloc.dart';

@immutable
sealed class MovieDeatailsEvent {}

class BookMovieButtonClickedEvent extends MovieDeatailsEvent {}
