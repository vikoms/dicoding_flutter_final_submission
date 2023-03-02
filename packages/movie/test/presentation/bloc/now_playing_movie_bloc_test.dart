import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/test_helper.mocks.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockNetworkInfo mockNetworkInfo;
  late NowPlayingMovieBloc nowPlayingMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockNetworkInfo = MockNetworkInfo();
    nowPlayingMovieBloc = NowPlayingMovieBloc(
      mockGetNowPlayingMovies,
      mockNetworkInfo,
    );
  });

  test('Initial state should be initial', () {
    expect(nowPlayingMovieBloc.state, NowPlayingMovieInitial());
  });

  final tMovieList = <Movie>[testMovie];
  group("When state is NowPlayingMovieInitial", () {
    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
        'emits [Loading,Loaded] when data movies is gotten successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingMovieBloc.emit(NowPlayingMovieInitial());
          return nowPlayingMovieBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
        expect: () => [
              NowPlayingMovieLoading(),
              NowPlayingMovieLoaded(movies: tMovieList),
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

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingMovieBloc.emit(NowPlayingMovieInitial());
          return nowPlayingMovieBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
        expect: () => [
              NowPlayingMovieLoading(),
              const NowPlayingMovieError(errorMessage: 'Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });
  });

  group("When state is NowPlayingMovieLoaded", () {
    final _page = 2;
    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
        'emits [Loaded] when pagination data movies is gotten successfully and has reached max = false, if exist more data',
        build: () {
          when(mockGetNowPlayingMovies.execute(page: _page))
              .thenAnswer((_) async => Right(tMovieList));

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingMovieBloc.emit(NowPlayingMovieLoaded(
            movies: tMovieList,
          ));
          return nowPlayingMovieBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
        expect: () => [
              NowPlayingMovieLoaded(
                movies: tMovieList + tMovieList,
                hasReachedMax: false,
              ),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute(page: _page));
        });

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
        'emits [Loaded] when pagination data movies is gotten successfully and has reached max = true, if no more data exist',
        build: () {
          when(mockGetNowPlayingMovies.execute(page: _page))
              .thenAnswer((_) async => Right([]));

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingMovieBloc.emit(NowPlayingMovieLoaded(
            movies: tMovieList,
          ));
          return nowPlayingMovieBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
        expect: () => [
              NowPlayingMovieLoaded(
                movies: tMovieList,
                hasReachedMax: true,
              ),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute(page: _page));
        });

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
        'emits [Error] when pagination data movies is unsuccessfully',
        build: () {
          when(mockGetNowPlayingMovies.execute(page: _page)).thenAnswer(
            (_) async => Left(
              ServerFailure('Server Failure'),
            ),
          );

          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          nowPlayingMovieBloc.emit(NowPlayingMovieLoaded(
            movies: [],
          ));
          return nowPlayingMovieBloc;
        },
        wait: const Duration(milliseconds: 500),
        act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
        expect: () => [
              const NowPlayingMovieError(errorMessage: 'Server Failure'),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute(page: _page));
        });
  });
}
