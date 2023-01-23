import 'package:core/core.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

import '../../models/series_table.dart';

abstract class SeriesLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable watchList);
  Future<String> removeWatchlist(WatchlistTable watchList);
  Future<void> cacheNowPlayingSeries(List<SeriesTable> series);
  Future<void> cachePopularSeries(List<SeriesTable> series);
  Future<void> cacheTopRatedSeries(List<SeriesTable> series);
  Future<List<SeriesTable>> getCachedNowPlayingSeries();
  Future<List<SeriesTable>> getCachedTopRatedSeries();
  Future<List<SeriesTable>> getCachedPopularSeries();
}

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  SeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable watchList) async {
    try {
      await databaseHelper.insertWatchlist(watchList);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable watchList) async {
    try {
      await databaseHelper.removeWatchlist(watchList);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheNowPlayingSeries(List<SeriesTable> series) async {
    await databaseHelper.clearCache(DatabaseHelper.CATEGORY_SERIES_NOW_PLAYING);
    await databaseHelper.insertCacheTransactionSeries(
        series, DatabaseHelper.CATEGORY_SERIES_NOW_PLAYING);
  }

  @override
  Future<List<SeriesTable>> getCachedNowPlayingSeries() async {
    final result = await databaseHelper
        .getCache(DatabaseHelper.CATEGORY_SERIES_NOW_PLAYING);
    if (result.length > 0) {
      return result.map((data) => SeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can''t get the data");
    }
  }

  @override
  Future<void> cachePopularSeries(List<SeriesTable> series) async {
    await databaseHelper.clearCache(DatabaseHelper.CATEGORY_SERIES_POPULAR);
    await databaseHelper.insertCacheTransactionSeries(
        series, DatabaseHelper.CATEGORY_SERIES_POPULAR);
  }

  @override
  Future<void> cacheTopRatedSeries(List<SeriesTable> series) async {
    await databaseHelper.clearCache(DatabaseHelper.CATEGORY_SERIES_TOP_RATED);
    await databaseHelper.insertCacheTransactionSeries(
        series, DatabaseHelper.CATEGORY_SERIES_TOP_RATED);
  }

  @override
  Future<List<SeriesTable>> getCachedPopularSeries() async {
    final result =
        await databaseHelper.getCache(DatabaseHelper.CATEGORY_SERIES_POPULAR);
    if (result.length > 0) {
      return result.map((data) => SeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can''t get the data");
    }
  }

  @override
  Future<List<SeriesTable>> getCachedTopRatedSeries() async {
    final result =
        await databaseHelper.getCache(DatabaseHelper.CATEGORY_SERIES_TOP_RATED);
    if (result.length > 0) {
      return result.map((data) => SeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can''t get the data");
    }
  }
}
