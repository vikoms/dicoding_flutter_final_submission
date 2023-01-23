// Mocks generated by Mockito 5.3.2 from annotations
// in movie/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/core.dart' as _i14;
import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/datasources/local/movie_local_data_source.dart'
    as _i11;
import 'package:movie/data/datasources/remote/movie_remote_data_source.dart'
    as _i9;
import 'package:movie/data/model/movie_detail_model.dart' as _i3;
import 'package:movie/data/model/movie_model.dart' as _i10;
import 'package:movie/data/model/movie_table.dart' as _i13;
import 'package:movie/domain/entities/movie.dart' as _i7;
import 'package:movie/domain/entities/movie_detail.dart' as _i8;
import 'package:movie/domain/repositories/movie_repository.dart' as _i4;
import 'package:series/data/models/series_table.dart' as _i16;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i15;
import 'package:watchlist/data/models/watchlist_table.dart' as _i12;

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

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i4.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>.value(
            _FakeEither_0<_i6.Failure, List<_i7.Movie>>(
          this,
          Invocation.method(
            #getNowPlayingMovies,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>.value(
            _FakeEither_0<_i6.Failure, List<_i7.Movie>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>.value(
            _FakeEither_0<_i6.Failure, List<_i7.Movie>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, _i8.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, _i8.MovieDetail>>.value(
            _FakeEither_0<_i6.Failure, _i8.MovieDetail>(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, _i8.MovieDetail>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>.value(
            _FakeEither_0<_i6.Failure, List<_i7.Movie>>(
          this,
          Invocation.method(
            #getMovieRecommendations,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>.value(
            _FakeEither_0<_i6.Failure, List<_i7.Movie>>(
          this,
          Invocation.method(
            #searchMovies,
            [query],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> saveWatchlist(
          _i8.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [movie],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
            _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [movie],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, String>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> removeWatchlist(
          _i8.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
            _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [movie],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, String>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i9.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i10.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue:
            _i5.Future<List<_i10.MovieModel>>.value(<_i10.MovieModel>[]),
      ) as _i5.Future<List<_i10.MovieModel>>);
  @override
  _i5.Future<List<_i10.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i5.Future<List<_i10.MovieModel>>.value(<_i10.MovieModel>[]),
      ) as _i5.Future<List<_i10.MovieModel>>);
  @override
  _i5.Future<List<_i10.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i5.Future<List<_i10.MovieModel>>.value(<_i10.MovieModel>[]),
      ) as _i5.Future<List<_i10.MovieModel>>);
  @override
  _i5.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i5.Future<_i3.MovieDetailResponse>.value(
            _FakeMovieDetailResponse_1(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.MovieDetailResponse>);
  @override
  _i5.Future<List<_i10.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue:
            _i5.Future<List<_i10.MovieModel>>.value(<_i10.MovieModel>[]),
      ) as _i5.Future<List<_i10.MovieModel>>);
  @override
  _i5.Future<List<_i10.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue:
            _i5.Future<List<_i10.MovieModel>>.value(<_i10.MovieModel>[]),
      ) as _i5.Future<List<_i10.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i11.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<String> insertWatchlist(_i12.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchList],
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<String> removeWatchlist(_i12.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [watchList],
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<void> cacheNowPlayingMovies(List<_i13.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheNowPlayingMovies,
          [movies],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> cachePopularMovies(List<_i13.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cachePopularMovies,
          [movies],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> cacaheTopRatedMovies(List<_i13.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacaheTopRatedMovies,
          [movies],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<List<_i13.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedNowPlayingMovies,
          [],
        ),
        returnValue:
            _i5.Future<List<_i13.MovieTable>>.value(<_i13.MovieTable>[]),
      ) as _i5.Future<List<_i13.MovieTable>>);
  @override
  _i5.Future<List<_i13.MovieTable>> getCachedPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedPopularMovies,
          [],
        ),
        returnValue:
            _i5.Future<List<_i13.MovieTable>>.value(<_i13.MovieTable>[]),
      ) as _i5.Future<List<_i13.MovieTable>>);
  @override
  _i5.Future<List<_i13.MovieTable>> getCachedTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedTopRatedMovies,
          [],
        ),
        returnValue:
            _i5.Future<List<_i13.MovieTable>>.value(<_i13.MovieTable>[]),
      ) as _i5.Future<List<_i13.MovieTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i14.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i15.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i5.Future<_i15.Database?>.value(),
      ) as _i5.Future<_i15.Database?>);
  @override
  _i5.Future<int> insertWatchlist(_i12.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchList],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<int> removeWatchlist(_i12.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [watchList],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<void> insertCacheTransaction(
    List<_i13.MovieTable>? movies,
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
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> insertCacheTransactionSeries(
    List<_i16.SeriesTable>? seriesList,
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
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<Map<String, dynamic>?> getWatchListById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchListById,
          [id],
        ),
        returnValue: _i5.Future<Map<String, dynamic>?>.value(),
      ) as _i5.Future<Map<String, dynamic>?>);
  @override
  _i5.Future<List<Map<String, dynamic>>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue: _i5.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i5.Future<List<Map<String, dynamic>>>);
  @override
  _i5.Future<List<Map<String, dynamic>>> getCache(String? category) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCache,
          [category],
        ),
        returnValue: _i5.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i5.Future<List<Map<String, dynamic>>>);
  @override
  _i5.Future<int> clearCache(String? category) => (super.noSuchMethod(
        Invocation.method(
          #clearCache,
          [category],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i14.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}
