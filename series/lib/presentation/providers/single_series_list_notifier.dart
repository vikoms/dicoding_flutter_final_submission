import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/series.dart';
import '../../domain/usecases/get_now_playing_series.dart';
import '../../domain/usecases/get_popular_series.dart';
import '../../domain/usecases/get_top_rated_series.dart';

class SingleSeriesListNotifier extends ChangeNotifier {
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;
  final GetNowPlayingSeries getNowPlayingSeries;

  SingleSeriesListNotifier({
    required this.getPopularSeries,
    required this.getTopRatedSeries,
    required this.getNowPlayingSeries,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _listSeries = [];
  List<Series> get listSeries => _listSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeries(SeriesListEnum type) async {
    switch (type) {
      case SeriesListEnum.NowPlaying:
        await fetchNowPlayingSeries();
        break;
      case SeriesListEnum.TopRated:
        await fetchTopRatedSeries();
        break;
      case SeriesListEnum.Popular:
        await fetchPopularSeries();
        break;
      default:
        break;
    }
  }

  Future<void> fetchNowPlayingSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (seriesData) {
      _listSeries = seriesData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (seriesData) {
      _listSeries = seriesData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchPopularSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (seriesData) {
      _listSeries = seriesData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
