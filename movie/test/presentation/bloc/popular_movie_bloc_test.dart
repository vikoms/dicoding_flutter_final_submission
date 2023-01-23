import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';

import '../../helpers/dummy_data.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc popularMovieBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('Initial state should be initial', () {
    expect(popularMovieBloc.state, PopularMovieInitial());
  });

  final tMovieList = <Movie>[testMovie];

  blocTest<PopularMovieBloc, PopularMovieState>(
      'emits [Loading,Loaded] when data movies is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularMovies()),
      expect: () => [
            PopularMovieLoading(),
            PopularMovieLoaded(tMovieList),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });

  blocTest<PopularMovieBloc, PopularMovieState>(
      'emits [Loading,Error] when data movies is unsuccessfully',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularMovies()),
      expect: () => [
            PopularMovieLoading(),
            PopularMovieError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });
}
