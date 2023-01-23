import 'package:core/data/db/database_helper.dart';
import 'package:core/utils/exception.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/data/datasources/local/series_local_data_source.dart';

import '../../../helpers/dummy_data.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl datasource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    datasource = SeriesLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testSeriesWatchListTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await datasource.insertWatchlist(testSeriesWatchListTable);

      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to databse is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testSeriesWatchListTable))
          .thenThrow(Exception());
      // act
      final call = datasource.insertWatchlist(testSeriesWatchListTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testSeriesWatchListTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await datasource.removeWatchlist(testSeriesWatchListTable);
      expect(result, 'Removed from Watchlist');
    });

    test('shoud throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testSeriesWatchListTable))
          .thenThrow(Exception());

      // act
      final call = datasource.removeWatchlist(testSeriesWatchListTable);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('cache now playing series', () {
    test('should call database helper to save data', () async {
      when(mockDatabaseHelper
              .clearCache(DatabaseHelper.CATEGORY_SERIES_NOW_PLAYING))
          .thenAnswer((_) async => 1);
      // act
      await datasource.cacheNowPlayingSeries([testSeriesCache]);

      // assert
      verify(mockDatabaseHelper
          .clearCache(DatabaseHelper.CATEGORY_SERIES_NOW_PLAYING));
      verify(mockDatabaseHelper.insertCacheTransactionSeries(
          [testSeriesCache], DatabaseHelper.CATEGORY_SERIES_NOW_PLAYING));
    });

    test('should return list of series from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper
              .getCache(DatabaseHelper.CATEGORY_SERIES_NOW_PLAYING))
          .thenAnswer((_) async => [testSeriesCacheMap]);

      // act
      final result = await datasource.getCachedNowPlayingSeries();

      // assert
      expect(result, [testSeriesCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper
              .getCache(DatabaseHelper.CATEGORY_SERIES_NOW_PLAYING))
          .thenAnswer((_) async => []);

      // act
      final call = datasource.getCachedNowPlayingSeries();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache popular series', () {
    test('should call database helper to save data', () async {
      when(mockDatabaseHelper
              .clearCache(DatabaseHelper.CATEGORY_SERIES_POPULAR))
          .thenAnswer((_) async => 1);
      // act
      await datasource.cachePopularSeries([testSeriesCache]);

      // assert
      verify(mockDatabaseHelper
          .clearCache(DatabaseHelper.CATEGORY_SERIES_POPULAR));
      verify(mockDatabaseHelper.insertCacheTransactionSeries(
          [testSeriesCache], DatabaseHelper.CATEGORY_SERIES_POPULAR));
    });

    test('should return list of series from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCache(DatabaseHelper.CATEGORY_SERIES_POPULAR))
          .thenAnswer((_) async => [testSeriesCacheMap]);

      // act
      final result = await datasource.getCachedPopularSeries();

      // assert
      expect(result, [testSeriesCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCache(DatabaseHelper.CATEGORY_SERIES_POPULAR))
          .thenAnswer((_) async => []);

      // act
      final call = datasource.getCachedPopularSeries();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache top rated series', () {
    test('should call database helper to save data', () async {
      when(mockDatabaseHelper
              .clearCache(DatabaseHelper.CATEGORY_SERIES_TOP_RATED))
          .thenAnswer((_) async => 1);
      // act
      await datasource.cacheTopRatedSeries([testSeriesCache]);

      // assert
      verify(mockDatabaseHelper
          .clearCache(DatabaseHelper.CATEGORY_SERIES_TOP_RATED));
      verify(mockDatabaseHelper.insertCacheTransactionSeries(
          [testSeriesCache], DatabaseHelper.CATEGORY_SERIES_TOP_RATED));
    });

    test('should return list of series from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper
              .getCache(DatabaseHelper.CATEGORY_SERIES_TOP_RATED))
          .thenAnswer((_) async => [testSeriesCacheMap]);

      // act
      final result = await datasource.getCachedTopRatedSeries();

      // assert
      expect(result, [testSeriesCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper
              .getCache(DatabaseHelper.CATEGORY_SERIES_TOP_RATED))
          .thenAnswer((_) async => []);

      // act
      final call = datasource.getCachedTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
