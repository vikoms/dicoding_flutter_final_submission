import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/series_popular/popular_series_bloc.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/test_helper.mocks.dart';
import 'bloc_mock_helper_test.mocks.dart';

void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesBloc popularSeriesBloc;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    mockNetworkInfo = MockNetworkInfo();
    popularSeriesBloc = PopularSeriesBloc(
      mockGetPopularSeries,
      mockNetworkInfo,
    );
  });

  final tSeriesList = <Series>[testSeries];

  test('Initial state should be initial', () {
    expect(popularSeriesBloc.state, PopularSeriesInitial());
  });

  group("When state is PopularSeriesInitial", () {
    blocTest<PopularSeriesBloc, PopularSeriesState>(
        'emits [Loading,Loaded] when data Seriess is gotten successfully',
        build: () {
          when(mockGetPopularSeries.execute())
              .thenAnswer((_) async => Right(tSeriesList));

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          popularSeriesBloc.emit(PopularSeriesInitial());
          return popularSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetPopularSeries()),
        expect: () => [
              PopularSeriesLoading(),
              PopularSeriesLoaded(series: tSeriesList),
            ],
        verify: (bloc) {
          verify(mockGetPopularSeries.execute());
        });

    blocTest<PopularSeriesBloc, PopularSeriesState>(
        'emits [Loading,Error] when data Seriess is unsuccessfully',
        build: () {
          when(mockGetPopularSeries.execute()).thenAnswer(
            (_) async => Left(
              ServerFailure('Server Failure'),
            ),
          );

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          popularSeriesBloc.emit(PopularSeriesInitial());
          return popularSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetPopularSeries()),
        expect: () => [
              PopularSeriesLoading(),
              const PopularSeriesError(errorMessage: 'Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetPopularSeries.execute());
        });
  });

  group("When state is PopularSeriesLoaded", () {
    final _page = 2;
    blocTest<PopularSeriesBloc, PopularSeriesState>(
        'emits [Loaded] when pagination data Seriess is gotten successfully and has reached max = false, if exist more data',
        build: () {
          when(mockGetPopularSeries.execute(page: _page))
              .thenAnswer((_) async => Right(tSeriesList));

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          popularSeriesBloc.emit(PopularSeriesLoaded(
            series: tSeriesList,
          ));
          return popularSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetPopularSeries()),
        expect: () => [
              PopularSeriesLoaded(
                series: tSeriesList + tSeriesList,
                hasReachedMax: false,
              ),
            ],
        verify: (bloc) {
          verify(mockGetPopularSeries.execute(page: _page));
        });

    blocTest<PopularSeriesBloc, PopularSeriesState>(
        'emits [Loaded] when pagination data Seriess is gotten successfully and has reached max = true, if no more data exist',
        build: () {
          when(mockGetPopularSeries.execute(page: _page))
              .thenAnswer((_) async => Right([]));

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          popularSeriesBloc.emit(PopularSeriesLoaded(
            series: tSeriesList,
          ));
          return popularSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetPopularSeries()),
        expect: () => [
              PopularSeriesLoaded(
                series: tSeriesList,
                hasReachedMax: true,
              ),
            ],
        verify: (bloc) {
          verify(mockGetPopularSeries.execute(page: _page));
        });

    blocTest<PopularSeriesBloc, PopularSeriesState>(
        'emits [Error] when pagination data Seriess is unsuccessfully',
        build: () {
          when(mockGetPopularSeries.execute(page: _page)).thenAnswer(
            (_) async => Left(
              ServerFailure('Server Failure'),
            ),
          );

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          popularSeriesBloc.emit(PopularSeriesLoaded(
            series: [],
          ));
          return popularSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetPopularSeries()),
        expect: () => [
              const PopularSeriesError(errorMessage: 'Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetPopularSeries.execute(page: _page));
        });
  });
}
