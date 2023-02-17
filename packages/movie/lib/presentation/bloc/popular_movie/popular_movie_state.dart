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
  final List<Movie> movies;
  bool hasReachedMax;
  RequestState pagingState;
  String message;
  PopularMovieLoaded({
    required this.movies,
    this.hasReachedMax = false,
    this.pagingState = RequestState.Empty,
    this.message = '',
  });

  PopularMovieLoaded copyWith({
    List<Movie>? movies,
    bool hasReachedMax = false,
    RequestState pagingState = RequestState.Empty,
    String message = '',
  }) =>
      PopularMovieLoaded(
        movies: movies ?? this.movies,
        hasReachedMax: hasReachedMax,
        pagingState: pagingState,
        message: message,
      );
  @override
  List<Object?> get props => [movies];
}
