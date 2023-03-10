// Mocks generated by Mockito 5.3.2 from annotations
// in series/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/core.dart' as _i16;
import 'package:core/data/models/genre_model.dart' as _i12;
import 'package:core/domain/entities/genre.dart' as _i9;
import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/model/movie_table.dart' as _i18;
import 'package:series/data/datasources/local/series_local_data_source.dart'
    as _i13;
import 'package:series/data/datasources/remote/series_remote_data_source.dart'
    as _i10;
import 'package:series/data/models/series_detail_model.dart' as _i3;
import 'package:series/data/models/series_model.dart' as _i11;
import 'package:series/data/models/series_table.dart' as _i15;
import 'package:series/domain/entities/series.dart' as _i7;
import 'package:series/domain/entities/series_detail.dart' as _i8;
import 'package:series/domain/repositories/series_repository.dart' as _i4;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i17;
import 'package:watchlist/data/models/watchlist_table.dart' as _i14;

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

class _FakeSeriesDetailResponse_1 extends _i1.SmartFake
    implements _i3.SeriesDetailResponse {
  _FakeSeriesDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRepository extends _i1.Mock implements _i4.SeriesRepository {
  MockSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>> getNowPlayingSeries(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingSeries,
          [],
          {#page: page},
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>.value(
                _FakeEither_0<_i6.Failure, List<_i7.Series>>(
          this,
          Invocation.method(
            #getNowPlayingSeries,
            [],
            {#page: page},
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>> getPopularSeries(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularSeries,
          [],
          {#page: page},
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>.value(
                _FakeEither_0<_i6.Failure, List<_i7.Series>>(
          this,
          Invocation.method(
            #getPopularSeries,
            [],
            {#page: page},
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>> getTopRatedSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedSeries,
          [],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>.value(
                _FakeEither_0<_i6.Failure, List<_i7.Series>>(
          this,
          Invocation.method(
            #getTopRatedSeries,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, _i8.SeriesDetail>> getDetailSeries(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetailSeries,
          [id],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, _i8.SeriesDetail>>.value(
                _FakeEither_0<_i6.Failure, _i8.SeriesDetail>(
          this,
          Invocation.method(
            #getDetailSeries,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, _i8.SeriesDetail>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>> searchSeries({
    required String? query,
    int? page = 1,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchSeries,
          [],
          {
            #query: query,
            #page: page,
          },
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>.value(
                _FakeEither_0<_i6.Failure, List<_i7.Series>>(
          this,
          Invocation.method(
            #searchSeries,
            [],
            {
              #query: query,
              #page: page,
            },
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> saveWatchlist(
          _i8.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlist,
          [series],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
            _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlist,
            [series],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, String>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> removeWatchlist(
          _i8.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [series],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
            _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [series],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, String>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>
      getSeriesRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getSeriesRecommendations,
              [id],
            ),
            returnValue:
                _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>.value(
                    _FakeEither_0<_i6.Failure, List<_i7.Series>>(
              this,
              Invocation.method(
                #getSeriesRecommendations,
                [id],
              ),
            )),
          ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>> getSeriesByGenre({
    required int? genreId,
    int? page = 1,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSeriesByGenre,
          [],
          {
            #genreId: genreId,
            #page: page,
          },
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>.value(
                _FakeEither_0<_i6.Failure, List<_i7.Series>>(
          this,
          Invocation.method(
            #getSeriesByGenre,
            [],
            {
              #genreId: genreId,
              #page: page,
            },
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Series>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i9.Genre>>> getSeriesGenres() =>
      (super.noSuchMethod(
        Invocation.method(
          #getSeriesGenres,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, List<_i9.Genre>>>.value(
            _FakeEither_0<_i6.Failure, List<_i9.Genre>>(
          this,
          Invocation.method(
            #getSeriesGenres,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i9.Genre>>>);
}

/// A class which mocks [SeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesRemoteDataSource extends _i1.Mock
    implements _i10.SeriesRemoteDataSource {
  MockSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i11.SeriesModel>> getNowPlayingSeries({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingSeries,
          [],
          {#page: page},
        ),
        returnValue:
            _i5.Future<List<_i11.SeriesModel>>.value(<_i11.SeriesModel>[]),
      ) as _i5.Future<List<_i11.SeriesModel>>);
  @override
  _i5.Future<List<_i11.SeriesModel>> getPopularSeries({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularSeries,
          [],
          {#page: page},
        ),
        returnValue:
            _i5.Future<List<_i11.SeriesModel>>.value(<_i11.SeriesModel>[]),
      ) as _i5.Future<List<_i11.SeriesModel>>);
  @override
  _i5.Future<_i3.SeriesDetailResponse> getDetailSeries(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDetailSeries,
          [id],
        ),
        returnValue: _i5.Future<_i3.SeriesDetailResponse>.value(
            _FakeSeriesDetailResponse_1(
          this,
          Invocation.method(
            #getDetailSeries,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.SeriesDetailResponse>);
  @override
  _i5.Future<List<_i11.SeriesModel>> getTopRatedSeries() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedSeries,
          [],
        ),
        returnValue:
            _i5.Future<List<_i11.SeriesModel>>.value(<_i11.SeriesModel>[]),
      ) as _i5.Future<List<_i11.SeriesModel>>);
  @override
  _i5.Future<List<_i11.SeriesModel>> searchSeries({
    required String? query,
    int? page = 1,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchSeries,
          [],
          {
            #query: query,
            #page: page,
          },
        ),
        returnValue:
            _i5.Future<List<_i11.SeriesModel>>.value(<_i11.SeriesModel>[]),
      ) as _i5.Future<List<_i11.SeriesModel>>);
  @override
  _i5.Future<List<_i11.SeriesModel>> getRecomendationSeries(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRecomendationSeries,
          [id],
        ),
        returnValue:
            _i5.Future<List<_i11.SeriesModel>>.value(<_i11.SeriesModel>[]),
      ) as _i5.Future<List<_i11.SeriesModel>>);
  @override
  _i5.Future<List<_i12.GenreModel>> getSeriesGenres() => (super.noSuchMethod(
        Invocation.method(
          #getSeriesGenres,
          [],
        ),
        returnValue:
            _i5.Future<List<_i12.GenreModel>>.value(<_i12.GenreModel>[]),
      ) as _i5.Future<List<_i12.GenreModel>>);
  @override
  _i5.Future<List<_i11.SeriesModel>> getSeriesByGenre({
    required int? genreId,
    int? page = 1,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSeriesByGenre,
          [],
          {
            #genreId: genreId,
            #page: page,
          },
        ),
        returnValue:
            _i5.Future<List<_i11.SeriesModel>>.value(<_i11.SeriesModel>[]),
      ) as _i5.Future<List<_i11.SeriesModel>>);
}

/// A class which mocks [SeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSeriesLocalDataSource extends _i1.Mock
    implements _i13.SeriesLocalDataSource {
  MockSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<String> insertWatchlist(_i14.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchList],
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<String> removeWatchlist(_i14.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [watchList],
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<void> cacheNowPlayingSeries(List<_i15.SeriesTable>? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheNowPlayingSeries,
          [series],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> cachePopularSeries(List<_i15.SeriesTable>? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #cachePopularSeries,
          [series],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> cacheTopRatedSeries(List<_i15.SeriesTable>? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheTopRatedSeries,
          [series],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<List<_i15.SeriesTable>> getCachedNowPlayingSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedNowPlayingSeries,
          [],
        ),
        returnValue:
            _i5.Future<List<_i15.SeriesTable>>.value(<_i15.SeriesTable>[]),
      ) as _i5.Future<List<_i15.SeriesTable>>);
  @override
  _i5.Future<List<_i15.SeriesTable>> getCachedTopRatedSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedTopRatedSeries,
          [],
        ),
        returnValue:
            _i5.Future<List<_i15.SeriesTable>>.value(<_i15.SeriesTable>[]),
      ) as _i5.Future<List<_i15.SeriesTable>>);
  @override
  _i5.Future<List<_i15.SeriesTable>> getCachedPopularSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedPopularSeries,
          [],
        ),
        returnValue:
            _i5.Future<List<_i15.SeriesTable>>.value(<_i15.SeriesTable>[]),
      ) as _i5.Future<List<_i15.SeriesTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i16.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i17.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i5.Future<_i17.Database?>.value(),
      ) as _i5.Future<_i17.Database?>);
  @override
  _i5.Future<int> insertWatchlist(_i14.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchList],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<int> removeWatchlist(_i14.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [watchList],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<void> insertCacheTransaction(
    List<_i18.MovieTable>? movies,
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
    List<_i15.SeriesTable>? seriesList,
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
class MockNetworkInfo extends _i1.Mock implements _i16.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}
