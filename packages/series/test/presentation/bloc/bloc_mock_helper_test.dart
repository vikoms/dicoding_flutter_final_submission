import 'package:mockito/annotations.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

@GenerateMocks([
  GetTopRatedSeries,
  GetNowPlayingSeries,
  GetPopularSeries,
  GetSeriesDetail,
  SaveWatchlistSeries,
  RemoveWatchlistSeries,
  GetWatchlistStatus,
  GetSeriesRecommendations,
])
void main() {}
