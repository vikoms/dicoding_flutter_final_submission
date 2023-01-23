part of 'now_playing_movie_bloc.dart';

@immutable
abstract class NowPlayingMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetNowPlayingMovies extends NowPlayingMovieEvent {
  OnGetNowPlayingMovies();
  @override
  List<Object?> get props => [];
}
