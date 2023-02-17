part of 'home_movie_bloc.dart';

@immutable
class HomeMovieState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;

  final RequestState nowPlayingState;
  final RequestState popularState;

  final String nowPlayingMessage;
  final String popularMessage;

  const HomeMovieState({
    this.nowPlayingMovies = const [],
    this.popularMovies = const [],
    this.nowPlayingState = RequestState.Empty,
    this.popularState = RequestState.Empty,
    this.nowPlayingMessage = '',
    this.popularMessage = '',
  });

  HomeMovieState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    RequestState? nowPlayingState,
    RequestState? popularState,
    String? nowPlayingMessage,
    String? popularMessage,
  }) =>
      HomeMovieState(
        nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
        popularMovies: popularMovies ?? this.popularMovies,
        nowPlayingState: nowPlayingState ?? this.nowPlayingState,
        popularState: popularState ?? this.popularState,
        nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
        popularMessage: popularMessage ?? this.popularMessage,
      );

  @override
  List<Object?> get props => [
        nowPlayingMovies,
        popularMovies,
        nowPlayingState,
        popularState,
        nowPlayingMessage,
        popularMessage,
      ];
}

class HomeMovieInitial extends HomeMovieState {}
