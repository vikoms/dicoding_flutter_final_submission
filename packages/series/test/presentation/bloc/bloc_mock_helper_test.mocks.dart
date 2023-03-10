// Mocks generated by Mockito 5.3.2 from annotations
// in series/test/presentation/bloc/bloc_mock_helper_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:series/domain/entities/series.dart' as _i8;
import 'package:series/domain/entities/series_detail.dart' as _i12;
import 'package:series/domain/repositories/series_repository.dart' as _i2;
import 'package:series/domain/usecases/get_now_playing_series.dart' as _i9;
import 'package:series/domain/usecases/get_popular_series.dart' as _i10;
import 'package:series/domain/usecases/get_series_detail.dart' as _i11;
import 'package:series/domain/usecases/get_series_recommendations.dart' as _i16;
import 'package:series/domain/usecases/get_top_rated_series.dart' as _i5;
import 'package:series/domain/usecases/remove_watchlist_series.dart' as _i14;
import 'package:series/domain/usecases/save_watchlist_series.dart' as _i13;
import 'package:watchlist/domain/repositories/watchlist_repository.dart' as _i4;
import 'package:watchlist/domain/usecases/get_watchlist_status.dart' as _i15;

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

class _FakeSeriesRepository_0 extends _i1.SmartFake
    implements _i2.SeriesRepository {
  _FakeSeriesRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWatchlistRepository_2 extends _i1.SmartFake
    implements _i4.WatchlistRepository {
  _FakeWatchlistRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTopRatedSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedSeries extends _i1.Mock implements _i5.GetTopRatedSeries {
  MockGetTopRatedSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>>.value(
                _FakeEither_1<_i7.Failure, List<_i8.Series>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>>);
}

/// A class which mocks [GetNowPlayingSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingSeries extends _i1.Mock
    implements _i9.GetNowPlayingSeries {
  MockGetNowPlayingSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>> execute(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#page: page},
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>>.value(
                _FakeEither_1<_i7.Failure, List<_i8.Series>>(
          this,
          Invocation.method(
            #execute,
            [],
            {#page: page},
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>>);
}

/// A class which mocks [GetPopularSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularSeries extends _i1.Mock implements _i10.GetPopularSeries {
  MockGetPopularSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>> execute(
          {int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#page: page},
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>>.value(
                _FakeEither_1<_i7.Failure, List<_i8.Series>>(
          this,
          Invocation.method(
            #execute,
            [],
            {#page: page},
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>>);
}

/// A class which mocks [GetSeriesDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesDetail extends _i1.Mock implements _i11.GetSeriesDetail {
  MockGetSeriesDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, _i12.SeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, _i12.SeriesDetail>>.value(
                _FakeEither_1<_i7.Failure, _i12.SeriesDetail>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, _i12.SeriesDetail>>);
}

/// A class which mocks [SaveWatchlistSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistSeries extends _i1.Mock
    implements _i13.SaveWatchlistSeries {
  MockSaveWatchlistSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, String>> execute(
          _i12.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [series],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, String>>.value(
            _FakeEither_1<_i7.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [series],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistSeries extends _i1.Mock
    implements _i14.RemoveWatchlistSeries {
  MockRemoveWatchlistSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, String>> execute(
          _i12.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [series],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, String>>.value(
            _FakeEither_1<_i7.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [series],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, String>>);
}

/// A class which mocks [GetWatchlistStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistStatus extends _i1.Mock
    implements _i15.GetWatchlistStatus {
  MockGetWatchlistStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.WatchlistRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeWatchlistRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.WatchlistRepository);
  @override
  _i6.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}

/// A class which mocks [GetSeriesRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesRecommendations extends _i1.Mock
    implements _i16.GetSeriesRecommendations {
  MockGetSeriesRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>>.value(
                _FakeEither_1<_i7.Failure, List<_i8.Series>>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i8.Series>>>);
}
