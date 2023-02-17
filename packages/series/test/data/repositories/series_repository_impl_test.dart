import 'dart:io';

import 'package:core/data/models/genre_model.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/data/repositories/series_repository_impl.dart';
import 'package:series/domain/entities/series.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesRepositoryImpl repository;
  late MockSeriesRemoteDataSource mockRemoteDataSource;
  late MockSeriesLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockSeriesRemoteDataSource();
    mockLocalDataSource = MockSeriesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SeriesRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  final tSeriesModel = SeriesModel(
    backdropPath: "backdropPath",
    firstAirDate: "firstAirDate",
    genreIds: [1, 2, 3],
    id: 130392,
    name: "The D'Amelio Show",
    originCountry: ['US'],
    originalLanguage: "originalLanguage",
    originalName: "The D'Amelio Show",
    overview:
        'From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.',
    popularity: 2.4,
    posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
    voteAverage: 25,
    voteCount: 124,
  );
  final tSeries = Series(
    backdropPath: "backdropPath",
    firstAirDate: "firstAirDate",
    genreIds: [1, 2, 3],
    id: 130392,
    name: "The D'Amelio Show",
    originCountry: ['US'],
    originalLanguage: "originalLanguage",
    originalName: "The D'Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 2.4,
    posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
    voteAverage: 25,
    voteCount: 124,
  );

  final tSeriesModelList = <SeriesModel>[tSeriesModel];
  final tSeriesList = <Series>[tSeries];

  group('Now Playing Series', () {
    test('should check if the device is online', () async {
      // arrage
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNowPlayingSeries())
          .thenAnswer((_) async => []);

      // act
      await repository.getNowPlayingSeries();

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
        when(mockRemoteDataSource.getNowPlayingSeries())
            .thenAnswer((_) async => tSeriesModelList);
        // act
        final result = await repository.getNowPlayingSeries();
        // assert
        verify(mockRemoteDataSource.getNowPlayingSeries());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      });

      test(
          'should cache data locally when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingSeries())
            .thenAnswer((_) async => tSeriesModelList);

        // act
        await repository.getNowPlayingSeries();

        // assert
        verify(mockRemoteDataSource.getNowPlayingSeries());
        verify(mockLocalDataSource.cacheNowPlayingSeries([testSeriesCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getNowPlayingSeries();
        // assert
        verify(mockRemoteDataSource.getNowPlayingSeries());
        expect(result, equals(Left(ServerFailure(''))));
      });

      test('should return SSL failure when certificate failed verification',
          () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingSeries())
            .thenThrow(TlsException());
        // act
        final result = await repository.getNowPlayingSeries();
        // assert
        verify(mockRemoteDataSource.getNowPlayingSeries());
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
        when(mockLocalDataSource.getCachedNowPlayingSeries())
            .thenAnswer((_) async => [testSeriesCache]);
        // act
        final result = await repository.getNowPlayingSeries();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testSeriesFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedNowPlayingSeries())
            .thenThrow(CacheException('No Cache'));

        // act
        final result = await repository.getNowPlayingSeries();

        // assert
        verify(mockLocalDataSource.getCachedNowPlayingSeries());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular Series', () {
    test('should check if the device is online', () async {
      // arrage
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getPopularSeries()).thenAnswer((_) async => []);

      // act
      await repository.getPopularSeries();

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
        when(mockRemoteDataSource.getPopularSeries())
            .thenAnswer((_) async => tSeriesModelList);
        // act
        final result = await repository.getPopularSeries();
        // assert
        verify(mockRemoteDataSource.getPopularSeries());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      });

      test(
          'should cache data locally when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularSeries())
            .thenAnswer((_) async => tSeriesModelList);

        // act
        await repository.getPopularSeries();

        // assert
        verify(mockRemoteDataSource.getPopularSeries());
        verify(mockLocalDataSource.cachePopularSeries([testSeriesCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getPopularSeries();
        // assert
        verify(mockRemoteDataSource.getPopularSeries());
        expect(result, equals(Left(ServerFailure(''))));
      });

      test(
          'should return socket exception when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularSeries())
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getPopularSeries();
        // assert
        verify(mockRemoteDataSource.getPopularSeries());
        expect(
            result,
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      });

      test('should return SSL failure when certificate failed verification',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularSeries()).thenThrow(TlsException());
        // act
        final result = await repository.getPopularSeries();
        // assert
        verify(mockRemoteDataSource.getPopularSeries());
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
        when(mockLocalDataSource.getCachedPopularSeries())
            .thenAnswer((_) async => [testSeriesCache]);
        // act
        final result = await repository.getPopularSeries();
        // assert
        verify(mockLocalDataSource.getCachedPopularSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testSeriesFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedPopularSeries())
            .thenThrow(CacheException('No Cache'));

        // act
        final result = await repository.getPopularSeries();

        // assert
        verify(mockLocalDataSource.getCachedPopularSeries());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Top Rated Series', () {
    test('should check if the device is online', () async {
      // arrage
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenAnswer((_) async => []);

      // act
      await repository.getTopRatedSeries();

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
        when(mockRemoteDataSource.getTopRatedSeries())
            .thenAnswer((_) async => tSeriesModelList);
        // act
        final result = await repository.getTopRatedSeries();
        // assert
        verify(mockRemoteDataSource.getTopRatedSeries());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      });

      test(
          'should cache data locally when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedSeries())
            .thenAnswer((_) async => tSeriesModelList);

        // act
        await repository.getTopRatedSeries();

        // assert
        verify(mockRemoteDataSource.getTopRatedSeries());
        verify(mockLocalDataSource.cacheTopRatedSeries([testSeriesCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedSeries();
        // assert
        verify(mockRemoteDataSource.getTopRatedSeries());
        expect(result, equals(Left(ServerFailure(''))));
      });

      test(
          'should return socket exception when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedSeries())
            .thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTopRatedSeries();
        // assert
        verify(mockRemoteDataSource.getTopRatedSeries());
        expect(
            result,
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      });

      test('should return SSL failure when certificate failed verification',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedSeries())
            .thenThrow(TlsException());
        // act
        final result = await repository.getTopRatedSeries();
        // assert
        verify(mockRemoteDataSource.getTopRatedSeries());
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
        when(mockLocalDataSource.getCachedTopRatedSeries())
            .thenAnswer((_) async => [testSeriesCache]);
        // act
        final result = await repository.getTopRatedSeries();
        // assert
        verify(mockLocalDataSource.getCachedTopRatedSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testSeriesFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedTopRatedSeries())
            .thenThrow(CacheException('No Cache'));

        // act
        final result = await repository.getTopRatedSeries();

        // assert
        verify(mockLocalDataSource.getCachedTopRatedSeries());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Get Series Detail', () {
    final tId = 1;
    final tSeriesResponse = SeriesDetailResponse(
      adult: false,
      backdropPath: "backdropPath",
      createdBy: [
        CreatedBy(
          id: 12,
          creditId: "123",
          name: "name",
          gender: 1,
          profilePath: "profilePath",
        ),
      ],
      episodeRunTime: [1, 2, 3],
      firstAirDate: "releaseDate",
      genres: [
        GenreModel(id: 1, name: "name"),
      ],
      homepage: "homepage",
      id: 1234,
      inProduction: false,
      languages: ['en'],
      lastAirDate: "lastAirDate",
      lastEpisodeToAir: LastEpisodeToAir(
          airDate: "airDate",
          episodeNumber: 12,
          id: 1,
          name: "name",
          overview: "overview",
          productionCode: "productionCode",
          runtime: 21,
          seasonNumber: 2,
          showId: 1,
          stillPath: "stillPath",
          voteAverage: 12,
          voteCount: 111),
      name: "name",
      nextEpisodeToAir: NextEpisodeToAir(
        airDate: "airDate",
        episodeNumber: 12,
        id: 1,
        name: "name",
        overview: "overview",
        productionCode: "productionCode",
        runtime: 1,
        seasonNumber: 1,
        showId: 1,
        stillPath: "stillPath",
        voteAverage: 12,
        voteCount: 12,
      ),
      networks: [
        Model(
            id: 1,
            name: "name",
            logoPath: "logoPath",
            originCountry: "originCountry")
      ],
      numberOfEpisodes: 12,
      numberOfSeasons: 2,
      originCountry: ['en-US'],
      originalLanguage: "en",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      productionCompanies: [
        Model(
          id: 1,
          name: "name",
          logoPath: "logoPath",
          originCountry: 'en',
        )
      ],
      productionCountries: [
        ProductionCountryModel(
          iso31661: "iso31661",
          name: "name",
        ),
      ],
      seasons: [
        SeasonModel(
          airDate: "airDate",
          episodeCount: 20,
          id: 12,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 12,
        ),
      ],
      spokenLanguages: [
        SpokenLanguage(
          englishName: "englishName",
          iso6391: "iso6391",
          name: "name",
        )
      ],
      status: "status",
      tagline: "tagline",
      type: "type",
      voteAverage: 20.3,
      voteCount: 1250,
    );

    test(
        'should return Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetailSeries(tId))
          .thenAnswer((_) async => tSeriesResponse);
      // act
      final result = await repository.getDetailSeries(tId);
      // assert
      verify(mockRemoteDataSource.getDetailSeries(tId));
      expect(result, equals(Right(testSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetailSeries(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getDetailSeries(tId);
      // assert
      verify(mockRemoteDataSource.getDetailSeries(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetailSeries(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetailSeries(tId);
      // assert
      verify(mockRemoteDataSource.getDetailSeries(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Series Recommendations', () {
    final tSeriesRecommendations = <SeriesModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecomendationSeries(tId))
          .thenAnswer((_) async => tSeriesRecommendations);
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getRecomendationSeries(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSeriesRecommendations));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecomendationSeries(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getRecomendationSeries(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecomendationSeries(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getRecomendationSeries(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Series', () {
    final tQuery = 'Shooter';

    test('should return Series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testSeriesWatchListTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testSeriesDetail2);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testSeriesWatchListTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testSeriesDetail2);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testSeriesWatchListTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testSeriesDetail2);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testSeriesWatchListTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testSeriesDetail2);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });
}
