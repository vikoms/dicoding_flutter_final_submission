part of 'top_rated_movie_bloc.dart';

@immutable
abstract class TopRatedMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetTopRatedMovies extends TopRatedMovieEvent {
  OnGetTopRatedMovies();
  @override
  List<Object?> get props => [];
}
