// Mocks generated by Mockito 5.3.2 from annotations
// in search/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:core/utils/failure.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/entities/movie.dart' as _i6;
import 'package:movie/domain/entities/movie_detail.dart' as _i7;
import 'package:movie/domain/repositories/movie_repository.dart' as _i3;
import 'package:series/domain/entities/series.dart' as _i9;
import 'package:series/domain/entities/series_detail.dart' as _i10;
import 'package:series/domain/repositories/series_repository.dart' as _i8;

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

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i3.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> getNowPlayingMovies(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Movie>>(
          this,
          Invocation.method(
            #getNowPlayingMovies,
            [],
            {#page: page},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> getPopularMovies(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Movie>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
            {#page: page},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> getTopRatedMovies(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
          {#page: page},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Movie>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
            {#page: page},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i7.MovieDetail>>.value(
            _FakeEither_0<_i5.Failure, _i7.MovieDetail>(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.MovieDetail>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Movie>>(
          this,
          Invocation.method(
            #getMovieRecommendations,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Movie>>(
          this,
          Invocation.method(
            #searchMovies,
            [query],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> saveWatchlist(
          _i7.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [movie],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [movie],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> removeWatchlist(
          _i7.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [movie],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
}

/// A class which mocks [SeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRepository extends _i1.Mock implements _i8.SeriesRepository {
  MockSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>> getNowPlayingSeries(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingSeries,
          [],
          {#page: page},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>.value(
                _FakeEither_0<_i5.Failure, List<_i9.Series>>(
          this,
          Invocation.method(
            #getNowPlayingSeries,
            [],
            {#page: page},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>> getPopularSeries(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularSeries,
          [],
          {#page: page},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>.value(
                _FakeEither_0<_i5.Failure, List<_i9.Series>>(
          this,
          Invocation.method(
            #getPopularSeries,
            [],
            {#page: page},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>> getTopRatedSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedSeries,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>.value(
                _FakeEither_0<_i5.Failure, List<_i9.Series>>(
          this,
          Invocation.method(
            #getTopRatedSeries,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i10.SeriesDetail>> getDetailSeries(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetailSeries,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i10.SeriesDetail>>.value(
                _FakeEither_0<_i5.Failure, _i10.SeriesDetail>(
          this,
          Invocation.method(
            #getDetailSeries,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i10.SeriesDetail>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>> searchSeries(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchSeries,
          [query],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>.value(
                _FakeEither_0<_i5.Failure, List<_i9.Series>>(
          this,
          Invocation.method(
            #searchSeries,
            [query],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> saveWatchlist(
          _i10.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [series],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [series],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> removeWatchlist(
          _i10.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [series],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [series],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>
      getSeriesRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getSeriesRecommendations,
              [id],
            ),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>.value(
                    _FakeEither_0<_i5.Failure, List<_i9.Series>>(
              this,
              Invocation.method(
                #getSeriesRecommendations,
                [id],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i9.Series>>>);
}