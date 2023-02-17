import 'package:core/data/db/database_helper.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/data/datasources/local/movie_local_data_source.dart';

import '../../../helpers/dummy_data.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieWatchListTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieWatchListTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieWatchListTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieWatchListTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieWatchListTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieWatchListTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieWatchListTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieWatchListTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  // group('Get Movie Detail By Id', () {
  //   final tId = 1;

  //   test('should return Movie Detail Table when data is found', () async {
  //     // arrange
  //     when(mockDatabaseHelper.getWatchListById(tId))
  //         .thenAnswer((_) async => testWatchListMovieMap);
  //     // act
  //     final result = await dataSource.getWatchListById(tId);
  //     // assert
  //     expect(result, testMovieWatchListTable);
  //   });

  //   test('should return null when data is not found', () async {
  //     // arrange
  //     when(mockDatabaseHelper.getWatchListById(tId))
  //         .thenAnswer((_) async => null);
  //     // act
  //     final result = await dataSource.getWatchListById(tId);
  //     // assert
  //     expect(result, null);
  //   });
  // });

  // group('get watchlist movies', () {
  //   test('should return list of MovieTable from database', () async {
  //     // arrange
  //     when(mockDatabaseHelper.getWatchlist())
  //         .thenAnswer((_) async => [testWatchListMovieMap]);
  //     // act
  //     final result = await dataSource.getWatchlist();
  //     // assert
  //     expect(result, [testMovieWatchListTable]);
  //   });
  // });

  group('cache now playing movies', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper
              .clearCache(DatabaseHelper.CATEGORY_MOVIES_NOW_PLAYING))
          .thenAnswer((_) async => 1);

      // act
      await dataSource.cacheNowPlayingMovies([testMovieCache]);

      // assert
      verify(mockDatabaseHelper
          .clearCache(DatabaseHelper.CATEGORY_MOVIES_NOW_PLAYING));
      verify(mockDatabaseHelper.insertCacheTransaction(
          [testMovieCache], DatabaseHelper.CATEGORY_MOVIES_NOW_PLAYING));
    });

    test('should return list of movies from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper
              .getCache(DatabaseHelper.CATEGORY_MOVIES_NOW_PLAYING))
          .thenAnswer((realInvocation) async => [testMovieCacheMap]);

      // act
      final result = await dataSource.getCachedNowPlayingMovies();

      // assert
      expect(result, [testMovieCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper
              .getCache(DatabaseHelper.CATEGORY_MOVIES_NOW_PLAYING))
          .thenAnswer((_) async => []);

      // act
      final call = dataSource.getCachedNowPlayingMovies();

      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache popular movies', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper
              .clearCache(DatabaseHelper.CATEGORY_MOVIES_POPULAR))
          .thenAnswer((_) async => 1);

      // act
      await dataSource.cachePopularMovies([testMovieCache]);

      // assert
      verify(mockDatabaseHelper
          .clearCache(DatabaseHelper.CATEGORY_MOVIES_POPULAR));
      verify(mockDatabaseHelper.insertCacheTransaction(
          [testMovieCache], DatabaseHelper.CATEGORY_MOVIES_POPULAR));
    });

    test('should return list of movies from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCache(DatabaseHelper.CATEGORY_MOVIES_POPULAR))
          .thenAnswer((realInvocation) async => [testMovieCacheMap]);

      // act
      final result = await dataSource.getCachedPopularMovies();

      // assert
      expect(result, [testMovieCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCache(DatabaseHelper.CATEGORY_MOVIES_POPULAR))
          .thenAnswer((_) async => []);

      // act
      final call = dataSource.getCachedPopularMovies();

      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache top rated movies', () {
    test('should call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper
              .clearCache(DatabaseHelper.CATEGORY_MOVIES_TOP_RATED))
          .thenAnswer((_) async => 1);

      // act
      await dataSource.cacaheTopRatedMovies([testMovieCache]);

      // assert
      verify(mockDatabaseHelper
          .clearCache(DatabaseHelper.CATEGORY_MOVIES_TOP_RATED));
      verify(mockDatabaseHelper.insertCacheTransaction(
          [testMovieCache], DatabaseHelper.CATEGORY_MOVIES_TOP_RATED));
    });

    test('should return list of movies from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper
              .getCache(DatabaseHelper.CATEGORY_MOVIES_TOP_RATED))
          .thenAnswer((realInvocation) async => [testMovieCacheMap]);

      // act
      final result = await dataSource.getCachedTopRatedMovies();

      // assert
      expect(result, [testMovieCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper
              .getCache(DatabaseHelper.CATEGORY_MOVIES_TOP_RATED))
          .thenAnswer((_) async => []);

      // act
      final call = dataSource.getCachedTopRatedMovies();

      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
