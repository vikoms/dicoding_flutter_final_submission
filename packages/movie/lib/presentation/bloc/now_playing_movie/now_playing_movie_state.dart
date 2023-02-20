part of 'now_playing_movie_bloc.dart';

@immutable
// abstract class NowPlayingMovieState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class NowPlayingMovieInitial extends NowPlayingMovieState {}

// class NowPlayingMoviesError extends NowPlayingMovieState {
//   String errorMessage;
//   NowPlayingMoviesError(this.errorMessage);
//   @override
//   List<Object?> get props => [errorMessage];
// }

// class NowPlayingMoviesLoading extends NowPlayingMovieState {}

// class NowPlayingMoviesLoaded extends NowPlayingMovieState {
//   final List<Movie> movies;
//   final bool hasReachedMax;
//   final RequestState pagingState;
//   final String message;

//   NowPlayingMoviesLoaded({
//     this.movies = const [],
//     this.hasReachedMax = false,
//     this.pagingState = RequestState.Empty,
//     this.message = '',
//   });

//   NowPlayingMoviesLoaded copyWith({
//     List<Movie>? newMovies,
//     bool? hasReachedMax,
//     RequestState? pagingState,
//     String? message,
//   }) {
//     return NowPlayingMoviesLoaded(
//       movies: newMovies ?? movies,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//       pagingState: pagingState ?? this.pagingState,
//       message: message ?? this.message,
//     );
//   }

//   @override
//   List<Object?> get props => [movies];
// }

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object?> get props => [];
}

class NowPlayingMovieInitial extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String errorMessage;

  const NowPlayingMovieError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class NowPlayingMovieLoaded extends NowPlayingMovieState {
  final List<Movie> movies;
  final bool hasReachedMax;

  const NowPlayingMovieLoaded({
    required this.movies,
    this.hasReachedMax = false,
  });

  NowPlayingMovieLoaded copyWith({
    List<Movie>? movies,
    bool? hasReachedMax,
  }) {
    return NowPlayingMovieLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [movies, hasReachedMax];
}
