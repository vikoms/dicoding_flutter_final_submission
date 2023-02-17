part of 'home_movie_bloc.dart';

@immutable
abstract class HomeMovieEvent extends Equatable {}

class OnGetNowPlayingMovie extends HomeMovieEvent {
  OnGetNowPlayingMovie();
  @override
  List<Object?> get props => [];
}

class OnGetPopularMovie extends HomeMovieEvent {
  OnGetPopularMovie();
  @override
  List<Object?> get props => [];
}
