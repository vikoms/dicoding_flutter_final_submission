import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/series_detail/series_detail_bloc.dart';

import '../../helpers/dummy_data.dart';
import 'bloc_mock_helper_test.mocks.dart';

main() {
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchlistStatus mockGetWatchlistStatus;
  late MockSaveWatchlistSeries mockSaveSeriesWatchlist;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;
  late SeriesDetailBloc seriesDetailBloc;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchlistStatus();
    mockSaveSeriesWatchlist = MockSaveWatchlistSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
    seriesDetailBloc = SeriesDetailBloc(
      mockGetSeriesDetail,
      mockGetWatchlistStatus,
      mockSaveSeriesWatchlist,
      mockRemoveWatchlistSeries,
      mockGetSeriesRecommendations,
    );
  });

  const tId = 1234;
  group('Series Detail', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [Loading,Loaded] when MovieDetail is successfully.',
      build: () {
        when(mockGetSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testSeriesDetail));

        when(mockGetSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => const Right(<Series>[]));

        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetSeriesDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        SeriesDetailState.initial().copyWith(
          seriesState: RequestState.Loading,
        ),
        SeriesDetailState.initial().copyWith(
          seriesState: RequestState.Loaded,
          series: testSeriesDetail,
          recommendationSeries: <Series>[],
        ),
      ],
      verify: (bloc) {
        mockGetSeriesDetail.execute(tId);
        mockGetSeriesRecommendations.execute(tId);
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [Loading, Error] when get series detail failed',
      build: () {
        when(mockGetSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        when(mockGetSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(<Series>[]));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetSeriesDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        SeriesDetailState.initial().copyWith(seriesState: RequestState.Loading),
        SeriesDetailState.initial().copyWith(
          seriesState: RequestState.Error,
          message: 'Error',
        ),
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(tId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [Loading, Error] when get series recommendations detail failed',
      build: () {
        when(mockGetSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testSeriesDetail));
        when(mockGetSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Error')));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetSeriesDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        SeriesDetailState.initial().copyWith(seriesState: RequestState.Loading),
        SeriesDetailState.initial().copyWith(
          seriesState: RequestState.Error,
          message: 'Server Error',
        ),
      ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(tId));
      },
    );
  });

  blocTest<SeriesDetailBloc, SeriesDetailState>(
    'emits [IsAddedToWatchlist] when OnGetWatchlist is fetched.',
    build: () {
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      return seriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlistStatus(tId)),
    expect: () => [
      SeriesDetailState.initial().copyWith(
        isAddedWatchlist: true,
      ),
    ],
    verify: (bloc) => verify(mockGetWatchlistStatus.execute(tId)),
  );

  group('Add series to watchlist', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [WatchlistMessage,isAddedToWatchlist] when OnAddSeriesWatchlist is successfully.',
      build: () {
        when(mockSaveSeriesWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return seriesDetailBloc;
      },
      act: (bloc) {
        bloc.add(OnAddSeriesWatchlist(testSeriesDetail));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => <SeriesDetailState>[
        SeriesDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedWatchlist: true,
        ),
      ],
      verify: (bloc) {
        verify(mockSaveSeriesWatchlist.execute(testSeriesDetail));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [WatchlistMessage] when OnAddSeriesWatchlist is failure.',
      build: () {
        when(mockSaveSeriesWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return seriesDetailBloc;
      },
      act: (bloc) {
        bloc.add(OnAddSeriesWatchlist(testSeriesDetail));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <SeriesDetailState>[
        SeriesDetailState.initial().copyWith(
          watchlistMessage: 'Error',
        ),
      ],
      verify: (bloc) {
        verify(mockSaveSeriesWatchlist.execute(testSeriesDetail));
      },
    );
  });

  group('Remove series to watchlist', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [WatchlistMessage,isAddedToWatchlist] when OnRemoveSeriesWatchlist is successfully.',
      build: () {
        when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnRemoveSeriesWatchlist(testSeriesDetail)),
      wait: const Duration(milliseconds: 100),
      expect: () => <SeriesDetailState>[
        SeriesDetailState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
          isAddedWatchlist: false,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'emits [WatchlistMessage] when OnRemoveSeriesWatchlist is failure.',
      build: () {
        when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return seriesDetailBloc;
      },
      act: (bloc) {
        bloc.add(OnRemoveSeriesWatchlist(testSeriesDetail));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => <SeriesDetailState>[
        SeriesDetailState.initial().copyWith(
          watchlistMessage: 'Error',
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
      },
    );
  });
}
