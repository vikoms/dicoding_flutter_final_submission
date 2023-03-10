// Mocks generated by Mockito 5.3.2 from annotations
// in watchlist/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:core/data/db/database_helper.dart' as _i6;
import 'package:core/utils/failure.dart' as _i11;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/model/movie_table.dart' as _i8;
import 'package:series/data/models/series_table.dart' as _i9;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i7;
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart'
    as _i3;
import 'package:watchlist/data/models/watchlist_table.dart' as _i5;
import 'package:watchlist/domain/entities/watchlist.dart' as _i12;
import 'package:watchlist/domain/repositories/watchlist_repository.dart'
    as _i10;

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

/// A class which mocks [WatchlistLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistLocalDataSource extends _i1.Mock
    implements _i3.WatchlistLocalDataSource {
  MockWatchlistLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i5.WatchlistTable?> getWatchListById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchListById,
          [id],
        ),
        returnValue: _i4.Future<_i5.WatchlistTable?>.value(),
      ) as _i4.Future<_i5.WatchlistTable?>);
  @override
  _i4.Future<List<_i5.WatchlistTable>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue:
            _i4.Future<List<_i5.WatchlistTable>>.value(<_i5.WatchlistTable>[]),
      ) as _i4.Future<List<_i5.WatchlistTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i6.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i7.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i4.Future<_i7.Database?>.value(),
      ) as _i4.Future<_i7.Database?>);
  @override
  _i4.Future<int> insertWatchlist(_i5.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchList],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<int> removeWatchlist(_i5.WatchlistTable? watchList) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [watchList],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<void> insertCacheTransaction(
    List<_i8.MovieTable>? movies,
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
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> insertCacheTransactionSeries(
    List<_i9.SeriesTable>? seriesList,
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
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<Map<String, dynamic>?> getWatchListById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchListById,
          [id],
        ),
        returnValue: _i4.Future<Map<String, dynamic>?>.value(),
      ) as _i4.Future<Map<String, dynamic>?>);
  @override
  _i4.Future<List<Map<String, dynamic>>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue: _i4.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i4.Future<List<Map<String, dynamic>>>);
  @override
  _i4.Future<List<Map<String, dynamic>>> getCache(String? category) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCache,
          [category],
        ),
        returnValue: _i4.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i4.Future<List<Map<String, dynamic>>>);
  @override
  _i4.Future<int> clearCache(String? category) => (super.noSuchMethod(
        Invocation.method(
          #clearCache,
          [category],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
}

/// A class which mocks [WatchlistRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistRepository extends _i1.Mock
    implements _i10.WatchlistRepository {
  MockWatchlistRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i11.Failure, List<_i12.Watchlist>>> getWatchlist() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i11.Failure, List<_i12.Watchlist>>>.value(
                _FakeEither_0<_i11.Failure, List<_i12.Watchlist>>(
          this,
          Invocation.method(
            #getWatchlist,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i11.Failure, List<_i12.Watchlist>>>);
  @override
  _i4.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
