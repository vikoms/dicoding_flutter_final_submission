import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/series_popular/popular_series_bloc.dart';
import 'package:series/presentation/bloc/series_top_rated/top_rated_series_bloc.dart';

import '../../helpers/dummy_data.dart';
import 'bloc_mock_helper_test.mocks.dart';

void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late TopRatedSeriesBloc topRatedSeriesBloc;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    topRatedSeriesBloc = TopRatedSeriesBloc(mockGetTopRatedSeries);
  });

  final tSeriesList = <Series>[testSeries];

  test('Initial state should be initial', () {
    expect(topRatedSeriesBloc.state, TopRatedSeriesInitial());
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'emits [Loading,Loaded] when TopRatedSeries is gotten successfully.',
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));
        return topRatedSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedSeries()),
      expect: () => [
            TopRatedSeriesLoading(),
            TopRatedSeriesLoaded(tSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
      'emits [Loading,Error] when TopRatedSeries is Failure.',
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Error')));
        return topRatedSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedSeries()),
      expect: () => [
            TopRatedSeriesLoading(),
            TopRatedSeriesError('Server Error'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      });
}
