import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/presentation/providers/single_series_list_notifier.dart';

import 'series_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTopRatedSeries,
  GetPopularSeries,
  GetNowPlayingSeries,
])
void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late SingleSeriesListNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    notifier = SingleSeriesListNotifier(
      getPopularSeries: mockGetPopularSeries,
      getTopRatedSeries: mockGetTopRatedSeries,
      getNowPlayingSeries: mockGetNowPlayingSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tSeries = Series(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: "posterPath",
    voteAverage: 1,
    voteCount: 1,
  );

  final tSeriesList = <Series>[tSeries];
  group('Top Rated Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      notifier.fetchSeries(SeriesListEnum.TopRated);
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change list series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await notifier.fetchSeries(SeriesListEnum.TopRated);
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.listSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchSeries(SeriesListEnum.TopRated);
      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Now Playing Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      notifier.fetchSeries(SeriesListEnum.NowPlaying);
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change list series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await notifier.fetchSeries(SeriesListEnum.NowPlaying);
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.listSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchSeries(SeriesListEnum.NowPlaying);
      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular Movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      notifier.fetchSeries(SeriesListEnum.Popular);
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await notifier.fetchSeries(SeriesListEnum.Popular);
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.listSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchSeries(SeriesListEnum.Popular);
      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
