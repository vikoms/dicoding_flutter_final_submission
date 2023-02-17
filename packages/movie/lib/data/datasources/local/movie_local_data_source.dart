import 'package:core/core.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

import '../../model/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable watchList);
  Future<String> removeWatchlist(WatchlistTable watchList);
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);
  Future<void> cachePopularMovies(List<MovieTable> movies);
  Future<void> cacaheTopRatedMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedNowPlayingMovies();
  Future<List<MovieTable>> getCachedPopularMovies();
  Future<List<MovieTable>> getCachedTopRatedMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

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
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCache(DatabaseHelper.CATEGORY_MOVIES_NOW_PLAYING);
    await databaseHelper.insertCacheTransaction(
        movies, DatabaseHelper.CATEGORY_MOVIES_NOW_PLAYING);
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper
        .getCache(DatabaseHelper.CATEGORY_MOVIES_NOW_PLAYING);
    if (result.length > 0) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cachePopularMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCache(DatabaseHelper.CATEGORY_MOVIES_POPULAR);
    await databaseHelper.insertCacheTransaction(
        movies, DatabaseHelper.CATEGORY_MOVIES_POPULAR);
  }

  @override
  Future<List<MovieTable>> getCachedPopularMovies() async {
    final result =
        await databaseHelper.getCache(DatabaseHelper.CATEGORY_MOVIES_POPULAR);
    if (result.length > 0) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can''t get the data");
    }
  }

  @override
  Future<void> cacaheTopRatedMovies(List<MovieTable> movies) async {
    await databaseHelper.clearCache(DatabaseHelper.CATEGORY_MOVIES_TOP_RATED);
    await databaseHelper.insertCacheTransaction(
        movies, DatabaseHelper.CATEGORY_MOVIES_TOP_RATED);
  }

  @override
  Future<List<MovieTable>> getCachedTopRatedMovies() async {
    final result =
        await databaseHelper.getCache(DatabaseHelper.CATEGORY_MOVIES_TOP_RATED);
    if (result.length > 0) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can''t get the data");
    }
  }
}
