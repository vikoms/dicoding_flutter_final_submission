import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';

import '../../helpers/dummy_data.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetTopRatedMovies,
])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc topRatedMovieBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  test('Initial state should be initial', () {
    expect(topRatedMovieBloc.state, TopRatedMovieInitial());
  });

  final tMovieList = <Movie>[testMovie];

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'emits [Loading,Loaded] when data movies is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedMovies()),
      expect: () => [
            TopRatedMovieLoading(),
            TopRatedMovieLoaded(tMovieList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'emits [Loading,Error] when data movies is unsuccessfully',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedMovies()),
      expect: () => [
            TopRatedMovieLoading(),
            TopRatedMovieError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });
}
