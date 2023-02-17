import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/series.dart';
import '../../domain/usecases/get_now_playing_series.dart';
import '../../domain/usecases/get_popular_series.dart';
import '../../domain/usecases/get_top_rated_series.dart';

class SeriesListNotifier extends ChangeNotifier {
  var _nowPlayingSeries = <Series>[];
  List<Series> get nowPlayingSeries => _nowPlayingSeries;

  var _popularSeries = <Series>[];
  List<Series> get popularSeries => _popularSeries;

  var _topRatedSeries = <Series>[];
  List<Series> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  String _message = '';
  String get message => _message;

  final GetNowPlayingSeries getNowPlayingSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;
  SeriesListNotifier({
    required this.getNowPlayingSeries,
    required this.getPopularSeries,
    required this.getTopRatedSeries,
  });

  Future<void> fetchNowPlayingSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final results = await getNowPlayingSeries.execute();

    results.fold((failure) {
      _nowPlayingState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (seriesData) {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingSeries = seriesData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final results = await getPopularSeries.execute();
    results.fold((failure) {
      _popularState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (seriesData) {
      _popularState = RequestState.Loaded;
      _popularSeries = seriesData;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final results = await getTopRatedSeries.execute();
    results.fold((failure) {
      _topRatedState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (series) {
      _topRatedState = RequestState.Loaded;
      _topRatedSeries = series;
      notifyListeners();
    });
  }
}
