import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

import '../../dummy_data/dummy_data.dart';

void main() {
  test('should be a subclass of Watchlist entity', () {
    expect(testMovieWatchList, isA<Watchlist>());
  });

  test('should return a valid WatchlistTable object from a MovieDetail entity',
      () {
    final result = WatchlistTable.fromMovieEntity(testMovieDetail);
    expect(result, equals(testMovieWatchListTable));
  });

  test('should return a valid WatchlistTable object from a SeriesDetail entity',
      () {
    final result = WatchlistTable.fromSeriesEntity(testSeriesDetail);
    expect(result.id, equals(1234));
    expect(result.title, equals("originalName"));
    expect(result.posterPath, equals("posterPath"));
    expect(result.overview, equals("overview"));
    expect(result.category, equals(WatchlistTable.SERIES));
  });

  test('should return a valid Map object from a WatchlistTable object', () {
    final result = testMovieWatchListTable.toJson();
    final expectedMap = {
      'id': 1,
      'title': "title",
      'posterPath': "posterPath",
      'overview': "overview",
      'category': WatchlistTable.MOVIE,
    };

    expect(result, equals(expectedMap));
  });

  test('should return a valid WatchlistTable object from a Map object', () {
    final map = {
      'id': 1,
      'title': "title",
      'posterPath': "posterPath",
      'overview': "overview",
      'category': WatchlistTable.MOVIE,
    };
    final result = WatchlistTable.fromMap(map);
    expect(result, equals(testMovieWatchListTable));
  });

  test('should return a valid Watchlist entity from a WatchlistTable object',
      () {
    final result = testMovieWatchListTable.toEntity();
    expect(result, equals(testMovieWatchList));
  });
}
