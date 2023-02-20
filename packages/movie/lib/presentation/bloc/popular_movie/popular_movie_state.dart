part of 'popular_movie_bloc.dart';

@immutable
abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object?> get props => [];
}

class PopularMovieInitial extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieError extends PopularMovieState {
  final String errorMessage;

  const PopularMovieError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> movies;
  final bool hasReachedMax;

  const PopularMovieLoaded({
    required this.movies,
    this.hasReachedMax = false,
  });

  PopularMovieLoaded copyWith({
    List<Movie>? movies,
    bool? hasReachedMax,
  }) {
    return PopularMovieLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [movies, hasReachedMax];
}
