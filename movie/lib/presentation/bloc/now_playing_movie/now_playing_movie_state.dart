part of 'now_playing_movie_bloc.dart';

@immutable
abstract class NowPlayingMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingMovieInitial extends NowPlayingMovieState {}

class NowPlayingMoviesError extends NowPlayingMovieState {
  String errorMessage;
  NowPlayingMoviesError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class NowPlayingMoviesLoading extends NowPlayingMovieState {}

class NowPlayingMoviesLoaded extends NowPlayingMovieState {
  List<Movie> movies;
  NowPlayingMoviesLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}
