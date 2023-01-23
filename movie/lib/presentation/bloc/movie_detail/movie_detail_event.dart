part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnGetDetailMovie extends MovieDetailEvent {
  final int movieId;
  OnGetDetailMovie(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class OnGetWatchlistStatus extends MovieDetailEvent {
  final int id;
  OnGetWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class OnAddWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movie;
  OnAddWatchlistMovie(this.movie);
  @override
  List<Object?> get props => [movie];
}

class OnRemoveWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movie;
  OnRemoveWatchlistMovie(this.movie);
  @override
  List<Object?> get props => [movie];
}
