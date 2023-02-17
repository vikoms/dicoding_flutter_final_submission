import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/series_now_playing/now_playing_series_bloc.dart';
import 'package:series/presentation/bloc/series_top_rated/top_rated_series_bloc.dart';

import '../../helpers/dummy_data.dart';
import 'bloc_mock_helper_test.mocks.dart';

void main() {
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late NowPlayingSeriesBloc nowPlayingSeriesBloc;

  setUp(() {
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    nowPlayingSeriesBloc = NowPlayingSeriesBloc(mockGetNowPlayingSeries);
  });

  final tSeriesList = <Series>[testSeries];

  test('Initial state should be initial', () {
    expect(nowPlayingSeriesBloc.state, NowPlayingSeriesInitial());
  });

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
      'emits [Loading,Loaded] when TopRatedSeries is gotten successfully.',
      build: () {
        when(mockGetNowPlayingSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));
        return nowPlayingSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingSeries()),
      expect: () => [
            NowPlayingSeriesLoading(),
            NowPlayingSeriesLoaded(tSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      });

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
      'emits [Loading,Error] when TopRatedSeries is Failure.',
      build: () {
        when(mockGetNowPlayingSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Error')));
        return nowPlayingSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingSeries()),
      expect: () => [
            NowPlayingSeriesLoading(),
            NowPlayingSeriesError('Server Error'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      });
}
