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
            NowPlayingMoviesLoaded(movies: tMovieList),
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

  group('OnGetmoreNowPlayingMovie', () {
    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'emits nothing internet no connection',
      build: () {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetMoreNowPlayingMovies()),
      expect: () => <NowPlayingMovieState>[],
    );

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'emits nothing when state is loading',
      build: () {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        return nowPlayingMovieBloc;
      },
      seed: () =>
          NowPlayingMoviesLoaded(movies: [], pagingState: RequestState.Loading),
      act: (bloc) => bloc.add(OnGetMoreNowPlayingMovies()),
      expect: () => <NowPlayingMovieState>[],
    );

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'emits nothing when hasReachedMax is true',
      build: () {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        return nowPlayingMovieBloc;
      },
      seed: () => NowPlayingMoviesLoaded(movies: [], hasReachedMax: true),
      act: (bloc) => bloc.add(OnGetMoreNowPlayingMovies()),
      expect: () => <NowPlayingMovieState>[],
    );
    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
        'emits [Loading,Loaded] when data movies is fetching',
        build: () {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));
          when(mockGetNowPlayingMovies.execute(page: 1))
              .thenAnswer((_) async => Right(tMovieList));
          return nowPlayingMovieBloc;
        },
        seed: () => NowPlayingMoviesLoaded(
              movies: [],
              hasReachedMax: false,
              pagingState: RequestState.Empty,
            ),
        act: (bloc) => bloc.add(OnGetMoreNowPlayingMovies()),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              NowPlayingMoviesLoaded(
                movies: tMovieList,
                hasReachedMax: false,
                pagingState: RequestState.Loaded,
              ),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute(page: 1));
        });

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
        'emits [Loading,Error] when data movies is gotten unsuccessfully',
        build: () {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));
          when(mockGetNowPlayingMovies.execute(page: 1))
              .thenAnswer((_) async => Left(ServerFailure('Server Error')));
          return nowPlayingMovieBloc;
        },
        seed: () => NowPlayingMoviesLoaded(
              movies: [],
              hasReachedMax: false,
              pagingState: RequestState.Empty,
            ),
        act: (bloc) => bloc.add(OnGetMoreNowPlayingMovies()),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              NowPlayingMoviesLoaded(
                  pagingState: RequestState.Error, message: 'Server Error'),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute(page: 1));
        });
  });
}
