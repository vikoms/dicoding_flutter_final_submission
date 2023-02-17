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
  final List<Movie> movies;
  final bool hasReachedMax;
  final RequestState pagingState;
  final String message;

  NowPlayingMoviesLoaded({
    this.movies = const [],
    this.hasReachedMax = false,
    this.pagingState = RequestState.Empty,
    this.message = '',
  });

  NowPlayingMoviesLoaded copyWith({
    List<Movie>? newMovies,
    bool? hasReachedMax,
    RequestState? pagingState,
    String? message,
  }) {
    return NowPlayingMoviesLoaded(
      movies: newMovies ?? movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pagingState: pagingState ?? this.pagingState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [movies];
}
