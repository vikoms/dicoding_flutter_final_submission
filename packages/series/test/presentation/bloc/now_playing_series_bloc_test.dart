import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/series_now_playing/now_playing_series_bloc.dart';
import 'package:series/presentation/bloc/series_top_rated/top_rated_series_bloc.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/test_helper.mocks.dart';
import 'bloc_mock_helper_test.mocks.dart';

void main() {
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late NowPlayingSeriesBloc nowPlayingSeriesBloc;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    mockNetworkInfo = MockNetworkInfo();
    nowPlayingSeriesBloc = NowPlayingSeriesBloc(
      mockGetNowPlayingSeries,
      mockNetworkInfo,
    );
  });

  final tSeriesList = <Series>[testSeries];

  test('Initial state should be initial', () {
    expect(nowPlayingSeriesBloc.state, NowPlayingSeriesInitial());
  });

  final tMovieList = <Series>[testSeries];
  group("When state is NowPlayingSeriesInitial", () {
    blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
        'emits [Loading,Loaded] when data Seriess is gotten successfully',
        build: () {
          when(mockGetNowPlayingSeries.execute())
              .thenAnswer((_) async => Right(tSeriesList));

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingSeriesBloc.emit(NowPlayingSeriesInitial());
          return nowPlayingSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingSeries()),
        expect: () => [
              NowPlayingSeriesLoading(),
              NowPlayingSeriesLoaded(series: tSeriesList),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingSeries.execute());
        });

    blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
        'emits [Loading,Error] when data Seriess is unsuccessfully',
        build: () {
          when(mockGetNowPlayingSeries.execute()).thenAnswer(
            (_) async => Left(
              ServerFailure('Server Failure'),
            ),
          );

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingSeriesBloc.emit(NowPlayingSeriesInitial());
          return nowPlayingSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingSeries()),
        expect: () => [
              NowPlayingSeriesLoading(),
              const NowPlayingSeriesError(errorMessage: 'Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingSeries.execute());
        });
  });

  group("When state is NowPlayingSeriesLoaded", () {
    final _page = 2;
    blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
        'emits [Loaded] when pagination data Seriess is gotten successfully and has reached max = false, if exist more data',
        build: () {
          when(mockGetNowPlayingSeries.execute(page: _page))
              .thenAnswer((_) async => Right(tSeriesList));

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingSeriesBloc.emit(NowPlayingSeriesLoaded(
            series: tSeriesList,
          ));
          return nowPlayingSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingSeries()),
        expect: () => [
              NowPlayingSeriesLoaded(
                series: tSeriesList + tSeriesList,
                hasReachedMax: false,
              ),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingSeries.execute(page: _page));
        });

    blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
        'emits [Loaded] when pagination data Seriess is gotten successfully and has reached max = true, if no more data exist',
        build: () {
          when(mockGetNowPlayingSeries.execute(page: _page))
              .thenAnswer((_) async => Right([]));

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingSeriesBloc.emit(NowPlayingSeriesLoaded(
            series: tSeriesList,
          ));
          return nowPlayingSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingSeries()),
        expect: () => [
              NowPlayingSeriesLoaded(
                series: tSeriesList,
                hasReachedMax: true,
              ),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingSeries.execute(page: _page));
        });

    blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
        'emits [Error] when pagination data Seriess is unsuccessfully',
        build: () {
          when(mockGetNowPlayingSeries.execute(page: _page)).thenAnswer(
            (_) async => Left(
              ServerFailure('Server Failure'),
            ),
          );

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingSeriesBloc.emit(NowPlayingSeriesLoaded(
            series: [],
          ));
          return nowPlayingSeriesBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingSeries()),
        expect: () => [
              const NowPlayingSeriesError(errorMessage: 'Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingSeries.execute(page: _page));
        });
  });
}
