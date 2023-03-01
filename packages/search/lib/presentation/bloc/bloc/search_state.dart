part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class GenreLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class GenreHasData extends SearchState {
  final List<Genre> result;
  GenreHasData(this.result);
  @override
  List<Object> get props => [result];
}

class SearchHasDataMovies extends SearchState {
  final List<Movie> result;
  final int? selectedGenreId;
  final bool hasReachedMax;
  final String query;
  SearchHasDataMovies({
    required this.result,
    this.selectedGenreId,
    this.query = "",
    this.hasReachedMax = false,
  });

  SearchHasDataMovies copyWith({
    int? selectedGenreId,
    String? query,
    bool? hasReachedMax,
  }) {
    return SearchHasDataMovies(
      result: result,
      query: query ?? this.query,
      selectedGenreId: selectedGenreId ?? this.selectedGenreId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [result];
}

class SearchHasDataSeries extends SearchState {
  final List<Series> result;
  final int? selectedGenreId;
  final bool hasReachedMax;
  final String query;
  SearchHasDataSeries({
    required this.result,
    this.selectedGenreId,
    this.query = "",
    this.hasReachedMax = false,
  });

  SearchHasDataSeries copyWith({
    int? selectedGenreId,
    String? query,
    bool? hasReachedMax,
  }) {
    return SearchHasDataSeries(
      result: result,
      query: query ?? this.query,
      selectedGenreId: selectedGenreId ?? this.selectedGenreId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [result];
}
