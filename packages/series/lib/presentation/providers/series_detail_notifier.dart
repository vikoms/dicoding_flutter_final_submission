import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

import '../../domain/entities/series.dart';
import '../../domain/entities/series_detail.dart';
import '../../domain/usecases/get_series_detail.dart';
import '../../domain/usecases/get_series_recommendations.dart';
import '../../domain/usecases/remove_watchlist_series.dart';
import '../../domain/usecases/save_watchlist_series.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchListAddSuccessMessage = "Added to Watchlist";
  static const watchListRemoveSuccessMessage = "Removed from Watchlist";

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final SaveWatchlistSeries saveWatchListSeries;
  final GetWatchlistStatus getWatchListStatus;
  final RemoveWatchlistSeries removeWatchlist;

  SeriesDetailNotifier({
    required this.getSeriesDetail,
    required this.getWatchListStatus,
    required this.saveWatchListSeries,
    required this.removeWatchlist,
    required this.getSeriesRecommendations,
  });

  late SeriesDetail _series;
  SeriesDetail get series => _series;

  RequestState _seriesState = RequestState.Empty;
  RequestState get seriesState => _seriesState;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  List<Series> _recommendationSeries = [];
  List<Series> get recommendationSeries => _recommendationSeries;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchList = false;
  bool get isAddedToWatchlist => _isAddedToWatchList;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchSeriesDetail(int id) async {
    _seriesState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getSeriesDetail.execute(id);
    final recommendations = await getSeriesRecommendations.execute(id);
    detailResult.fold((failure) {
      _seriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (series) async {
      _series = series;
      _recommendationState = RequestState.Loading;
      notifyListeners();
      recommendations.fold((failure) {
        _recommendationState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      }, (recommendations) {
        _recommendationState = RequestState.Loaded;
        _recommendationSeries = recommendations;
        notifyListeners();
      });
      _seriesState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> addWatchList(SeriesDetail series) async {
    final result = await saveWatchListSeries.execute(series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );
    await loadWatchlistStatus(series.id);
  }

  Future<void> removeFromWatchlist(SeriesDetail series) async {
    final result = await removeWatchlist.execute(series);
    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedToWatchList = result;
    notifyListeners();
  }
}
