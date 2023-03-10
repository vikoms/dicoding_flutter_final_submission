import 'dart:io';

import 'package:core/domain/entities/genre.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/data/model/movie_detail_model.dart';
import 'package:movie/data/model/movie_model.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/entities/movie.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tGenreModel = GenreModel(id: 1, name: "name");
  final tGenre = Genre(id: 1, name: "name");

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];
  final tGenreModelList = <GenreModel>[tGenreModel];
  final tGenreList = <Genre>[tGenre];

  group('Now Playing Movies', () {
    test('should check if the device is online', () async {
      // arrage
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNowPlayingMovies())
          .thenAnswer((_) async => []);

      // act
      await repository.getNowPlayingMovies();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tMovieList);
      });

      test(
          'should cache data locally when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        await repository.getNowPlayingMovies();

        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        verify(mockLocalDataSource.cacheNowPlayingMovies([testMovieCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        expect(result, equals(Left(ServerFailure(''))));
      });
      test('should return SSL failure when certificate failed verification',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenThrow(TlsException());
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        expect(result,
            equals(Left(SSLFailure('Certificate Verification Failed'))));
      });
    });

    group('when device s offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingMovies())
            .thenAnswer((_) async => [testMovieCache]);
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingMovies())
            .thenThrow(CacheException('No Cache'));

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        verify(mockLocalDataSource.getCachedNowPlayingMovies());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });
  group('Popular Movies', () {
    test('should check if the device is online', () async {
      // arrage
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularMovies()).thenAnswer((_) async => []);

      // act
      await repository.getPopularMovies();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return movie list when call to data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.getPopularMovies();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tMovieList);
      });

      test(
          'should return server failure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getPopularMovies();
        // assert
        expect(result, Left(ServerFailure('')));
      });

      test(
          'should return connection failure when device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getPopularMovies();
        // assert
        expect(result,
            Left(ConnectionFailure('Failed to connect to the network')));
      });

      test('should return SSL failure when certificate failed verification',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies()).thenThrow(TlsException());
        // act
        final result = await repository.getPopularMovies();
        // assert
        verify(mockRemoteDataSource.getPopularMovies());
        expect(result,
            equals(Left(SSLFailure('Certificate Verification Failed'))));
      });
    });

    group('when device s offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedPopularMovies())
            .thenAnswer((_) async => [testMovieCache]);
        // act
        final result = await repository.getPopularMovies();
        // assert
        verify(mockLocalDataSource.getCachedPopularMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedPopularMovies())
            .thenThrow(CacheException('No Cache'));

        // act
        final result = await repository.getPopularMovies();

        // assert
        verify(mockLocalDataSource.getCachedPopularMovies());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Top Rated Movies', () {
    test('should check if the device is online', () async {
      // arrage
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopRatedMovies())
          .thenAnswer((_) async => []);

      // act
      await repository.getTopRatedMovies();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return movie list when call to data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tMovieList);
      });

      test(
          'should return ServerFailure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        expect(result, Left(ServerFailure('')));
      });

      test(
          'should return ConnectionFailure when device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        expect(result,
            Left(ConnectionFailure('Failed to connect to the network')));
      });
      test('should return SSL failure when certificate failed verification',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenThrow(TlsException());
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        verify(mockRemoteDataSource.getTopRatedMovies());
        expect(result,
            equals(Left(SSLFailure('Certificate Verification Failed'))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCachedTopRatedMovies())
            .thenAnswer((_) async => [testMovieCache]);
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        verify(mockLocalDataSource.getCachedTopRatedMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedTopRatedMovies())
            .thenThrow(CacheException('No Cache'));

        // act
        final result = await repository.getTopRatedMovies();

        // assert
        verify(mockLocalDataSource.getCachedTopRatedMovies());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(Right(testMovieDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataSource.getMovieDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Movies', () {
    final tQuery = 'spiderman';
    final tPage = 1;

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery, tPage))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.searchMovies(tQuery, tPage);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery, tPage))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchMovies(tQuery, tPage);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery, tPage))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchMovies(tQuery, tPage);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Movie Genres', () {
    test('should return genre list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieGenres())
          .thenAnswer((_) async => tGenreModelList);
      // act
      final result = await repository.getMovieGenres();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tGenreList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieGenres()).thenThrow(ServerException());
      // act
      final result = await repository.getMovieGenres();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovieGenres())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMovieGenres();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Series By Genre', () {
    final tGenreId = 28;
    final _page = 1;
    test('should return movies when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMoviesByGenre(tGenreId, _page))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.getMoviesByGenre(tGenreId, _page);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMoviesByGenre(tGenreId, _page))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMoviesByGenre(tGenreId, _page);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMoviesByGenre(tGenreId, _page))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMoviesByGenre(tGenreId, _page);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieWatchListTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testMovieWatchListTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieWatchListTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieWatchListTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  // group('get watchlist status', () {
  //   test('should return watch status whether data is found', () async {
  //     // arrange
  //     final tId = 1;
  //     when(mockLocalDataSource.getWatchListById(tId))
  //         .thenAnswer((_) async => null);
  //     // act
  //     final result = await repository.isAddedToWatchlist(tId);
  //     // assert
  //     expect(result, false);
  //   });
  // });

  // group('get watchlist movies', () {
  //   test('should return list of Movies', () async {
  //     // arrange
  //     when(mockLocalDataSource.getWatchlist())
  //         .thenAnswer((_) async => [testMovieWatchListTable]);
  //     // act
  //     final result = await repository.getWatchlistMovies();
  //     // assert
  //     final resultList = result.getOrElse(() => []);
  //     expect(resultList, [testMovieWatchList]);
  //   });
  // });
}
