import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/series_popular/popular_series_bloc.dart';

import '../../helpers/dummy_data.dart';
import 'bloc_mock_helper_test.mocks.dart';

void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesBloc popularSeriesBloc;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    popularSeriesBloc = PopularSeriesBloc(mockGetPopularSeries);
  });

  final tSeriesList = <Series>[testSeries];

  test('Initial state should be initial', () {
    expect(popularSeriesBloc.state, PopularSeriesInitial());
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
      'emits [Loading,Loaded] when TopRatedSeries is gotten successfully.',
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));
        return popularSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularSeries()),
      expect: () => [
            PopularSeriesLoading(),
            PopularSeriesLoaded(tSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
      'emits [Loading,Error] when TopRatedSeries is Failure.',
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Error')));
        return popularSeriesBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularSeries()),
      expect: () => [
            PopularSeriesLoading(),
            PopularSeriesError('Server Error'),
          ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      });
}
