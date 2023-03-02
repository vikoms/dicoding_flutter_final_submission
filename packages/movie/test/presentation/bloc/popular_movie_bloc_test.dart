import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/test_helper.mocks.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MockNetworkInfo mockNetworkInfo;
  late PopularMovieBloc popularMovieBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockNetworkInfo = MockNetworkInfo();
    popularMovieBloc = PopularMovieBloc(
      mockGetPopularMovies,
      mockNetworkInfo,
    );
  });

  test('Initial state should be initial', () {
    expect(popularMovieBloc.state, PopularMovieInitial());
  });

  final tMovieList = <Movie>[testMovie];
  final tError = ServerFailure('Error');
  final tInitial = PopularMovieInitial();
  final tLoading = PopularMovieLoading();
  final tLoaded = PopularMovieLoaded(movies: tMovieList, hasReachedMax: false);
  final tLoadedMax =
      PopularMovieLoaded(movies: tMovieList, hasReachedMax: true);
  final tErrorState = PopularMovieError(errorMessage: tError.message);

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [Loading, Loaded] when OnGetPopularMovies event is added and network is connected',
    build: () {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularMovieBloc;
    },
    wait: const Duration(milliseconds: 500),
    act: (bloc) => bloc.add(OnGetPopularMovies()),
    expect: () => [tLoading, tLoaded],
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [Loading, Error] when OnGetPopularMovies event is added and getPopularMovies returns error',
    build: () {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(tError));
      return popularMovieBloc;
    },
    wait: const Duration(milliseconds: 500),
    act: (bloc) => bloc.add(OnGetPopularMovies()),
    expect: () => [tLoading, tErrorState],
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [Loaded(hasReachedMax: true)] when OnGetPopularMovies event is added and getPopularMovies returns empty list',
    build: () {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGetPopularMovies.execute(page: 2))
          .thenAnswer((_) async => Right([]));
      popularMovieBloc.emit(tLoaded);
      return popularMovieBloc;
    },
    wait: const Duration(milliseconds: 500),
    act: (bloc) => bloc.add(OnGetPopularMovies()),
    expect: () => [tLoadedMax],
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [] when OnGetPopularMovies event is added but there are no more pages',
    build: () {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockGetPopularMovies.execute(page: 2))
          .thenAnswer((_) async => Right([]));
      popularMovieBloc = PopularMovieBloc(
        mockGetPopularMovies,
        mockNetworkInfo,
      );
      popularMovieBloc.emit(tLoadedMax);
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(OnGetPopularMovies()),
    expect: () => [],
  );
}
