part of 'popular_movie_bloc.dart';

@immutable
abstract class PopularMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetPopularMovies extends PopularMovieEvent {
  OnGetPopularMovies();
  @override
  List<Object?> get props => [];
}

class OnGetMorePopularMovies extends PopularMovieEvent {
  OnGetMorePopularMovies();
  @override
  List<Object?> get props => [];
}
