import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_series.dart';
import 'package:series/domain/entities/series.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchSeries searchSeries;

  SearchNotifier({
    required this.searchMovies,
    required this.searchSeries,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _movieResult = [];
  List<Movie> get movieResult => _movieResult;

  List<Series> _seriesResult = [];
  List<Series> get seriesResult => _seriesResult;

  String _message = '';
  String get message => _message;

  void emptyResult() {
    _movieResult = [];
    _seriesResult = [];
  }

  Future<void> fetchSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _seriesResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _movieResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
