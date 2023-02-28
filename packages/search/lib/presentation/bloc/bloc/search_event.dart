part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnGetGenres extends SearchEvent {
  final String genreType;
  const OnGetGenres(this.genreType);
  @override
  List<Object> get props => [genreType];
}

class OnGetMoviesByGenre extends SearchEvent {
  final int genreId;
  const OnGetMoviesByGenre(this.genreId);
  @override
  List<Object> get props => [genreId];
}

class OnGetSeriesByGenre extends SearchEvent {
  final int genreId;
  const OnGetSeriesByGenre(this.genreId);
  @override
  List<Object> get props => [genreId];
}

class OnQueryChangeMovies extends SearchEvent {
  final String query;
  OnQueryChangeMovies(this.query);

  @override
  List<Object> get props => [query];
}

class OnQueryChangeSeries extends SearchEvent {
  final String query;
  OnQueryChangeSeries(this.query);

  @override
  List<Object> get props => [query];
}

class OnGetMoreMovies extends SearchEvent {
  const OnGetMoreMovies();

  @override
  List<Object> get props => [];
}
