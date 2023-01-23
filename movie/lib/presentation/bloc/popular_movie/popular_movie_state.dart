part of 'popular_movie_bloc.dart';

@immutable
abstract class PopularMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularMovieInitial extends PopularMovieState {}

class PopularMovieError extends PopularMovieState {
  String errorMessage;
  PopularMovieError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  List<Movie> movies;
  PopularMovieLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}
