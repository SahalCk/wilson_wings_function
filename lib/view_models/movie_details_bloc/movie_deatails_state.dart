part of 'movie_deatails_bloc.dart';

@immutable
sealed class MovieDeatailsState {}

final class MovieDeatailsInitial extends MovieDeatailsState {}

abstract class MovieDeatailsActionState extends MovieDeatailsState {}

class MovieBookedState extends MovieDeatailsActionState {}

class MovieBookedFailedState extends MovieDeatailsActionState {}
