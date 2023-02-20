part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
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
