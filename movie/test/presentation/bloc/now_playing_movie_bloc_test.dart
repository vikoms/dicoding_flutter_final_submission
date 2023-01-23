import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';

import '../../helpers/dummy_data.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMovieBloc nowPlayingMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  test('Initial state should be initial', () {
    expect(nowPlayingMovieBloc.state, NowPlayingMovieInitial());
  });

  final tMovieList = <Movie>[testMovie];

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'emits [Loading,Loaded] when data movies is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
      expect: () => [
            NowPlayingMoviesLoading(),
            NowPlayingMoviesLoaded(tMovieList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'emits [Loading,Error] when data movies is unsuccessfully',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
      expect: () => [
            NowPlayingMoviesLoading(),
            NowPlayingMoviesError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });
}
