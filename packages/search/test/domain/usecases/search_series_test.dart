import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_series.dart';
import 'package:series/domain/entities/series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SearchSeries(mockSeriesRepository);
  });

  final tMovies = <Series>[];
  final tQuery = 'Shooter';
  final tPage = 1;

  test('should get list of series from the repository', () async {
    // arrange
    when(mockSeriesRepository.searchSeries(query: tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tQuery, tPage);
    // assert
    expect(result, Right(tMovies));
  });
}
