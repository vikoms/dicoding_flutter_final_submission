import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_series.dart';
import 'package:series/domain/entities/series.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SearchSeries _searchSeries;

  SearchBloc(this._searchMovies, this._searchSeries) : super(SearchEmpty()) {
    on<OnQueryChangeMovies>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (data) {
        emit(SearchHasDataMovies(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<OnQueryChangeSeries>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchSeries.execute(query);
      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (data) {
        emit(SearchHasDataSeries(data));
      });
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  void emptyState() {
    emit(SearchEmpty());
  }
}
