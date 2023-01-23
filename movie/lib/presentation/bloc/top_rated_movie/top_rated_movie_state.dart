part of 'top_rated_movie_bloc.dart';

@immutable
abstract class TopRatedMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieError extends TopRatedMovieState {
  String errorMessage;
  TopRatedMovieError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieLoaded extends TopRatedMovieState {
  List<Movie> movies;
  TopRatedMovieLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}
