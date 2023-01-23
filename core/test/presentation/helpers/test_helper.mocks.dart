// Mocks generated by Mockito 5.3.2 from annotations
// in core/test/presentation/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:core/core.dart' as _i22;
import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/datasources/local/movie_local_data_source.dart'
    as _i15;
import 'package:movie/data/datasources/remote/movie_remote_data_source.dart'
    as _i13;
import 'package:movie/data/model/movie_detail_model.dart' as _i3;
import 'package:movie/data/model/movie_model.dart' as _i14;
import 'package:movie/data/model/movie_table.dart' as _i17;
import 'package:movie/domain/entities/movie.dart' as _i8;
import 'package:movie/domain/entities/movie_detail.dart' as _i9;
import 'package:movie/domain/repositories/movie_repository.dart' as _i5;
import 'package:series/data/datasources/local/series_local_data_source.dart'
    as _i20;
import 'package:series/data/datasources/remote/series_remote_data_source.dart'
    as _i18;
import 'package:series/data/models/series_detail_model.dart' as _i4;
import 'package:series/data/models/series_model.dart' as _i19;
import 'package:series/data/models/series_table.dart' as _i21;
import 'package:series/domain/entities/series.dart' as _i11;
import 'package:series/domain/entities/series_detail.dart' as _i12;
import 'package:series/domain/repositories/series_repository.dart' as _i10;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i23;
import 'package:watchlist/data/models/watchlist_table.dart' as _i16;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSeriesDetailResponse_2 extends _i1.SmartFake
    implements _i4.SeriesDetailResponse {
  _FakeSeriesDetailResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i5.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
            _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
          this,
          Invocation.method(
            #getNowPlayingMovies,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
            _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
            _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>.value(
            _FakeEither_0<_i7.Failure, _i9.MovieDetail>(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
            _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
          this,
          Invocation.method(
            #getMovieRecommendations,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
            _FakeEither_0<_i7.Failure, List<_i8.Movie>>(
          this,
          Invocation.method(
            #searchMovies,
            [query],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [movie],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [movie],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [movie],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
}

/// A class which mocks [SeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRepository extends _i1.Mock implements _i10.SeriesRepository {
  MockSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>
      getNowPlayingSeries() => (super.noSuchMethod(
            Invocation.method(
              #getNowPlayingSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i11.Series>>(
              this,
              Invocation.method(
                #getNowPlayingSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>> getPopularSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularSeries,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>.value(
                _FakeEither_0<_i7.Failure, List<_i11.Series>>(
          this,
          Invocation.method(
            #getPopularSeries,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>> getTopRatedSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedSeries,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>.value(
                _FakeEither_0<_i7.Failure, List<_i11.Series>>(
          this,
          Invocation.method(
            #getTopRatedSeries,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i12.SeriesDetail>> getDetailSeries(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetailSeries,
          [id],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i12.SeriesDetail>>.value(
                _FakeEither_0<_i7.Failure, _i12.SeriesDetail>(
          this,
          Invocation.method(
            #getDetailSeries,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i12.SeriesDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>> searchSeries(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchSeries,
          [query],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>.value(
                _FakeEither_0<_i7.Failure, List<_i11.Series>>(
          this,
          Invocation.method(
            #searchSeries,
            [query],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i12.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [series],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [series],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i12.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [series],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [series],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>
      getSeriesRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getSeriesRecommendations,
              [id],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i11.Series>>(
              this,
              Invocation.method(
                #getSeriesRecommendations,
                [id],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i11.Series>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i13.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i14.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue:
            _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]),
      ) as _i6.Future<List<_i14.MovieModel>>);
  @override
  _i6.Future<List<_i14.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]),
      ) as _i6.Future<List<_i14.MovieModel>>);
  @override
  _i6.Future<List<_i14.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]),
      ) as _i6.Future<List<_i14.MovieModel>>);
  @override
  _i6.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i6.Future<_i3.MovieDetailResponse>.value(
            _FakeMovieDetailResponse_1(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.MovieDetailResponse>);
  @override
  _i6.Future<List<_i14.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue:
            _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]),
      ) as _i6.Future<List<_i14.MovieModel>>);
  @override
  _i6.Future<List<_i14.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue:
            _i6.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]),
      ) as _i6.Future<List<_i14.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i15.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i16.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchList],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<String> removeWatchlist(_i16.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [watchList],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<void> cacheNowPlayingMovies(List<_i17.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheNowPlayingMovies,
          [movies],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> cachePopularMovies(List<_i17.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cachePopularMovies,
          [movies],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> cacaheTopRatedMovies(List<_i17.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacaheTopRatedMovies,
          [movies],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<List<_i17.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedNowPlayingMovies,
          [],
        ),
        returnValue:
            _i6.Future<List<_i17.MovieTable>>.value(<_i17.MovieTable>[]),
      ) as _i6.Future<List<_i17.MovieTable>>);
  @override
  _i6.Future<List<_i17.MovieTable>> getCachedPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedPopularMovies,
          [],
        ),
        returnValue:
            _i6.Future<List<_i17.MovieTable>>.value(<_i17.MovieTable>[]),
      ) as _i6.Future<List<_i17.MovieTable>>);
  @override
  _i6.Future<List<_i17.MovieTable>> getCachedTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedTopRatedMovies,
          [],
        ),
        returnValue:
            _i6.Future<List<_i17.MovieTable>>.value(<_i17.MovieTable>[]),
      ) as _i6.Future<List<_i17.MovieTable>>);
}

/// A class which mocks [SeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRemoteDataSource extends _i1.Mock
    implements _i18.SeriesRemoteDataSource {
  MockSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i19.SeriesModel>> getNowPlayingSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i19.SeriesModel>>.value(<_i19.SeriesModel>[]),
      ) as _i6.Future<List<_i19.SeriesModel>>);
  @override
  _i6.Future<List<_i19.SeriesModel>> getPopularSeries() => (super.noSuchMethod(
        Invocation.method(
          #getPopularSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i19.SeriesModel>>.value(<_i19.SeriesModel>[]),
      ) as _i6.Future<List<_i19.SeriesModel>>);
  @override
  _i6.Future<_i4.SeriesDetailResponse> getDetailSeries(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetailSeries,
          [id],
        ),
        returnValue: _i6.Future<_i4.SeriesDetailResponse>.value(
            _FakeSeriesDetailResponse_2(
          this,
          Invocation.method(
            #getDetailSeries,
            [id],
          ),
        )),
      ) as _i6.Future<_i4.SeriesDetailResponse>);
  @override
  _i6.Future<List<_i19.SeriesModel>> getTopRatedSeries() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i19.SeriesModel>>.value(<_i19.SeriesModel>[]),
      ) as _i6.Future<List<_i19.SeriesModel>>);
  @override
  _i6.Future<List<_i19.SeriesModel>> searchSeries(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchSeries,
          [query],
        ),
        returnValue:
            _i6.Future<List<_i19.SeriesModel>>.value(<_i19.SeriesModel>[]),
      ) as _i6.Future<List<_i19.SeriesModel>>);
  @override
  _i6.Future<List<_i19.SeriesModel>> getRecomendationSeries(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRecomendationSeries,
          [id],
        ),
        returnValue:
            _i6.Future<List<_i19.SeriesModel>>.value(<_i19.SeriesModel>[]),
      ) as _i6.Future<List<_i19.SeriesModel>>);
}

/// A class which mocks [SeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesLocalDataSource extends _i1.Mock
    implements _i20.SeriesLocalDataSource {
  MockSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i16.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchList],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<String> removeWatchlist(_i16.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [watchList],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<List<_i16.WatchlistTable>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue: _i6.Future<List<_i16.WatchlistTable>>.value(
            <_i16.WatchlistTable>[]),
      ) as _i6.Future<List<_i16.WatchlistTable>>);
  @override
  _i6.Future<void> cacheNowPlayingSeries(List<_i21.SeriesTable>? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheNowPlayingSeries,
          [series],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> cachePopularSeries(List<_i21.SeriesTable>? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #cachePopularSeries,
          [series],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> cacheTopRatedSeries(List<_i21.SeriesTable>? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheTopRatedSeries,
          [series],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<List<_i21.SeriesTable>> getCachedNowPlayingSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedNowPlayingSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i21.SeriesTable>>.value(<_i21.SeriesTable>[]),
      ) as _i6.Future<List<_i21.SeriesTable>>);
  @override
  _i6.Future<List<_i21.SeriesTable>> getCachedTopRatedSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedTopRatedSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i21.SeriesTable>>.value(<_i21.SeriesTable>[]),
      ) as _i6.Future<List<_i21.SeriesTable>>);
  @override
  _i6.Future<List<_i21.SeriesTable>> getCachedPopularSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedPopularSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i21.SeriesTable>>.value(<_i21.SeriesTable>[]),
      ) as _i6.Future<List<_i21.SeriesTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i22.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i23.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i6.Future<_i23.Database?>.value(),
      ) as _i6.Future<_i23.Database?>);
  @override
  _i6.Future<int> insertWatchlist(_i16.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchList],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<int> removeWatchlist(_i16.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [watchList],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<void> insertCacheTransaction(
    List<_i17.MovieTable>? movies,
    String? category,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertCacheTransaction,
          [
            movies,
            category,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> insertCacheTransactionSeries(
    List<_i21.SeriesTable>? seriesList,
    String? category,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertCacheTransactionSeries,
          [
            seriesList,
            category,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<Map<String, dynamic>?> getWatchListById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchListById,
          [id],
        ),
        returnValue: _i6.Future<Map<String, dynamic>?>.value(),
      ) as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getCache(String? category) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCache,
          [category],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<int> clearCache(String? category) => (super.noSuchMethod(
        Invocation.method(
          #clearCache,
          [category],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i22.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}
