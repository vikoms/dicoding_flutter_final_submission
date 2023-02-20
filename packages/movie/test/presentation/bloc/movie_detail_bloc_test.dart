import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

import '../../helpers/dummy_data.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchlistStatus,
  SaveMovieWatchlist,
  RemoveWatchlistMovie,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchlistStatus mockGetWatchlistStatus;
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchlistStatus();
    mockSaveMovieWatchlist = MockSaveMovieWatchlist();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchlistStatus,
      mockRemoveWatchlistMovie,
      mockSaveMovieWatchlist,
    );
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [Loading, Loaded] when get movie detail is successful',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(<Movie>[]));
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetDetailMovie(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailState().copyWith(movieState: RequestState.Loading),
      MovieDetailState().copyWith(
        movieState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: true,
      ),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(1));
      verify(mockGetMovieRecommendations.execute(1));
      verify(mockGetWatchlistStatus.execute(1));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [Loading, Error] when get movie detail failed',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Error')));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(<Movie>[]));
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetDetailMovie(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailState().copyWith(movieState: RequestState.Loading),
      MovieDetailState().copyWith(
        movieState: RequestState.Error,
        message: 'Error',
      ),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(1));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [Loading, Error] when get movie recommendations detail failed',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure("Server Error")));
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnGetDetailMovie(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailState().copyWith(movieState: RequestState.Loading),
      MovieDetailState().copyWith(
        movieState: RequestState.Error,
        message: 'Server Error',
      ),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(1));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [isAddedToWtchlist] when get watchlist status successfully.',
      build: () {
        when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistStatus(1)),
      expect: () => [
            MovieDetailState().copyWith(isAddedToWatchlist: true),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(1));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [WatchlistMessage] when adding movie to watchlist successfully',
    build: () {
      when(mockSaveMovieWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnAddWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailState().copyWith(
        isAddedToWatchlist: true,
        watchlistMessage: 'Added to Watchlist',
      ),
    ],
    verify: (bloc) {
      verify(mockSaveMovieWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [WatchlistMessage] when adding movie to watchlist failed',
    build: () {
      when(mockSaveMovieWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Error')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnAddWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailState().copyWith(watchlistMessage: 'Error'),
    ],
    verify: (bloc) {
      verify(mockSaveMovieWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [WatchlistMessage] and update isAddedToWatchlist to false when removing movie from watchlist successfully',
    build: () {
      when(mockRemoveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed from watchlist'));

      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => false);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailState().copyWith(
          isAddedToWatchlist: false,
          watchlistMessage: 'Removed from watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
      verify(mockGetWatchlistStatus.execute(1));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [WatchlistMessage] when remove movie to watchlist failed',
    build: () {
      when(mockRemoveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Error')));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(OnRemoveWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieDetailState().copyWith(watchlistMessage: 'Error'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
    },
  );
}
