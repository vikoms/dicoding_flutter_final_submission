import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_series.dart';
import 'package:search/presentation/bloc/bloc/search_bloc.dart';

import '../providers/search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchSeries])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchSeries = MockSearchSeries();
    searchBloc = SearchBloc(mockSearchMovies, mockSearchSeries);
  });

  test('Initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: '/path/to/backdrop.jpg',
    genreIds: [1, 2, 3],
    id: 123,
    originalTitle: 'Original Title',
    overview: 'This is a movie about something.',
    popularity: 10.0,
    posterPath: '/path/to/poster.jpg',
    releaseDate: '2022-01-01',
    title: 'Movie Title',
    video: false,
    voteAverage: 8.0,
    voteCount: 1000,
  );

  final tMovieList = <Movie>[tMovie];

  final tQuery = "spiderman";

  blocTest<SearchBloc, SearchState>(
    'emits [Loading,HasData] when data movies is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangeMovies(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SearchLoading(),
      SearchHasDataMovies(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchBloc, SearchState>(
      'emits [Loading,Error] when get search is unsuccessfully.',
      build: () {
        when(mockSearchSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangeMovies(tQuery)),
      expect: () => [
            SearchLoading(),
            SearchError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      });
}
