// Mocks generated by Mockito 5.3.2 from annotations
// in core/test/presentation/pages/home_movie_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:ui' as _i13;

import 'package:bloc/bloc.dart' as _i9;
import 'package:core/core.dart' as _i12;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/entities/movie.dart' as _i11;
import 'package:movie/domain/usecases/get_now_playing_movies.dart' as _i6;
import 'package:movie/domain/usecases/get_popular_movies.dart' as _i4;
import 'package:movie/domain/usecases/get_top_rated_movies.dart' as _i2;
import 'package:movie/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart'
    as _i7;
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart'
    as _i5;
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart'
    as _i3;
import 'package:movie/presentation/providers/movie_list_notifier.dart' as _i10;

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

class _FakeGetTopRatedMovies_0 extends _i1.SmartFake
    implements _i2.GetTopRatedMovies {
  _FakeGetTopRatedMovies_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTopRatedMovieState_1 extends _i1.SmartFake
    implements _i3.TopRatedMovieState {
  _FakeTopRatedMovieState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetPopularMovies_2 extends _i1.SmartFake
    implements _i4.GetPopularMovies {
  _FakeGetPopularMovies_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePopularMovieState_3 extends _i1.SmartFake
    implements _i5.PopularMovieState {
  _FakePopularMovieState_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetNowPlayingMovies_4 extends _i1.SmartFake
    implements _i6.GetNowPlayingMovies {
  _FakeGetNowPlayingMovies_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNowPlayingMovieState_5 extends _i1.SmartFake
    implements _i7.NowPlayingMovieState {
  _FakeNowPlayingMovieState_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TopRatedMovieBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedMovieBloc extends _i1.Mock implements _i3.TopRatedMovieBloc {
  MockTopRatedMovieBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTopRatedMovies get getTopRatedMovies => (super.noSuchMethod(
        Invocation.getter(#getTopRatedMovies),
        returnValue: _FakeGetTopRatedMovies_0(
          this,
          Invocation.getter(#getTopRatedMovies),
        ),
      ) as _i2.GetTopRatedMovies);
  @override
  _i3.TopRatedMovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeTopRatedMovieState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.TopRatedMovieState);
  @override
  _i8.Stream<_i3.TopRatedMovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i8.Stream<_i3.TopRatedMovieState>.empty(),
      ) as _i8.Stream<_i3.TopRatedMovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i3.TopRatedMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i3.TopRatedMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i3.TopRatedMovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i3.TopRatedMovieEvent>(
    _i9.EventHandler<E, _i3.TopRatedMovieState>? handler, {
    _i9.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i9.Transition<_i3.TopRatedMovieEvent, _i3.TopRatedMovieState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i8.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void onChange(_i9.Change<_i3.TopRatedMovieState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [PopularMovieBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularMovieBloc extends _i1.Mock implements _i5.PopularMovieBloc {
  MockPopularMovieBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.GetPopularMovies get getPopularMovies => (super.noSuchMethod(
        Invocation.getter(#getPopularMovies),
        returnValue: _FakeGetPopularMovies_2(
          this,
          Invocation.getter(#getPopularMovies),
        ),
      ) as _i4.GetPopularMovies);
  @override
  _i5.PopularMovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakePopularMovieState_3(
          this,
          Invocation.getter(#state),
        ),
      ) as _i5.PopularMovieState);
  @override
  _i8.Stream<_i5.PopularMovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i8.Stream<_i5.PopularMovieState>.empty(),
      ) as _i8.Stream<_i5.PopularMovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i5.PopularMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i5.PopularMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i5.PopularMovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i5.PopularMovieEvent>(
    _i9.EventHandler<E, _i5.PopularMovieState>? handler, {
    _i9.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i9.Transition<_i5.PopularMovieEvent, _i5.PopularMovieState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i8.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void onChange(_i9.Change<_i5.PopularMovieState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [NowPlayingMovieBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockNowPlayingMovieBloc extends _i1.Mock
    implements _i7.NowPlayingMovieBloc {
  MockNowPlayingMovieBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.GetNowPlayingMovies get getNowPlayingMovies => (super.noSuchMethod(
        Invocation.getter(#getNowPlayingMovies),
        returnValue: _FakeGetNowPlayingMovies_4(
          this,
          Invocation.getter(#getNowPlayingMovies),
        ),
      ) as _i6.GetNowPlayingMovies);
  @override
  _i7.NowPlayingMovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeNowPlayingMovieState_5(
          this,
          Invocation.getter(#state),
        ),
      ) as _i7.NowPlayingMovieState);
  @override
  _i8.Stream<_i7.NowPlayingMovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i8.Stream<_i7.NowPlayingMovieState>.empty(),
      ) as _i8.Stream<_i7.NowPlayingMovieState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  void add(_i7.NowPlayingMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i7.NowPlayingMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i7.NowPlayingMovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i7.NowPlayingMovieEvent>(
    _i9.EventHandler<E, _i7.NowPlayingMovieState>? handler, {
    _i9.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i9.Transition<_i7.NowPlayingMovieEvent, _i7.NowPlayingMovieState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i8.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void onChange(_i9.Change<_i7.NowPlayingMovieState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [MovieListNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieListNotifier extends _i1.Mock implements _i10.MovieListNotifier {
  MockMovieListNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.GetNowPlayingMovies get getNowPlayingMovies => (super.noSuchMethod(
        Invocation.getter(#getNowPlayingMovies),
        returnValue: _FakeGetNowPlayingMovies_4(
          this,
          Invocation.getter(#getNowPlayingMovies),
        ),
      ) as _i6.GetNowPlayingMovies);
  @override
  _i4.GetPopularMovies get getPopularMovies => (super.noSuchMethod(
        Invocation.getter(#getPopularMovies),
        returnValue: _FakeGetPopularMovies_2(
          this,
          Invocation.getter(#getPopularMovies),
        ),
      ) as _i4.GetPopularMovies);
  @override
  _i2.GetTopRatedMovies get getTopRatedMovies => (super.noSuchMethod(
        Invocation.getter(#getTopRatedMovies),
        returnValue: _FakeGetTopRatedMovies_0(
          this,
          Invocation.getter(#getTopRatedMovies),
        ),
      ) as _i2.GetTopRatedMovies);
  @override
  List<_i11.Movie> get nowPlayingMovies => (super.noSuchMethod(
        Invocation.getter(#nowPlayingMovies),
        returnValue: <_i11.Movie>[],
      ) as List<_i11.Movie>);
  @override
  _i12.RequestState get nowPlayingState => (super.noSuchMethod(
        Invocation.getter(#nowPlayingState),
        returnValue: _i12.RequestState.Empty,
      ) as _i12.RequestState);
  @override
  List<_i11.Movie> get popularMovies => (super.noSuchMethod(
        Invocation.getter(#popularMovies),
        returnValue: <_i11.Movie>[],
      ) as List<_i11.Movie>);
  @override
  _i12.RequestState get popularMoviesState => (super.noSuchMethod(
        Invocation.getter(#popularMoviesState),
        returnValue: _i12.RequestState.Empty,
      ) as _i12.RequestState);
  @override
  List<_i11.Movie> get topRatedMovies => (super.noSuchMethod(
        Invocation.getter(#topRatedMovies),
        returnValue: <_i11.Movie>[],
      ) as List<_i11.Movie>);
  @override
  _i12.RequestState get topRatedMoviesState => (super.noSuchMethod(
        Invocation.getter(#topRatedMoviesState),
        returnValue: _i12.RequestState.Empty,
      ) as _i12.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i8.Future<void> fetchNowPlayingMovies() => (super.noSuchMethod(
        Invocation.method(
          #fetchNowPlayingMovies,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #fetchPopularMovies,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #fetchTopRatedMovies,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void addListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i13.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}