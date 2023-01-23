import 'package:core/presentation/widgets/item_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/providers/movie_list_notifier.dart';
import 'package:provider/provider.dart';

import 'home_movie_page_test.mocks.dart';

@GenerateMocks([
  TopRatedMovieBloc,
  PopularMovieBloc,
  NowPlayingMovieBloc,
  MovieListNotifier
])
void main() {
  late MockMovieListNotifier provider;
  setUp(() {
    provider = MockMovieListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieListNotifier>.value(
      value: provider,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'HomeMoviePage displays movie lists and headings correctly when data is loaded',
      (WidgetTester tester) async {
    // Stub the state properties to return the RequestState.Loaded value
    when(provider.nowPlayingState).thenReturn(RequestState.Loaded);
    when(provider.popularMoviesState).thenReturn(RequestState.Loaded);
    when(provider.topRatedMoviesState).thenReturn(RequestState.Loaded);
    when(provider.nowPlayingMovies).thenReturn(<Movie>[]);
    when(provider.topRatedMovies).thenReturn(<Movie>[]);
    when(provider.popularMovies).thenReturn(<Movie>[]);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeMoviePage(),
      ),
    );

    // Verify that the "Now Playing" heading is displayed correctly
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.byType(ItemList), findsOneWidget);
    expect(find.byType(MovieList), findsNWidgets(2));
  });

  testWidgets(
      'HomeMoviePage displays progress bar and headings correctly when data is loading',
      (WidgetTester tester) async {
    // Stub the state properties to return the RequestState.Loaded value
    when(provider.nowPlayingState).thenReturn(RequestState.Loading);
    when(provider.popularMoviesState).thenReturn(RequestState.Loading);
    when(provider.topRatedMoviesState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeMoviePage(),
      ),
    );

    // Verify that the "Now Playing" heading is displayed correctly
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
  });

  testWidgets('HomeMoviePage displays text with message Error when error',
      (WidgetTester tester) async {
    // Stub the state properties to return the RequestState.Loaded value
    when(provider.nowPlayingState).thenReturn(RequestState.Error);
    when(provider.popularMoviesState).thenReturn(RequestState.Error);
    when(provider.topRatedMoviesState).thenReturn(RequestState.Error);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeMoviePage(),
      ),
    );

    // Verify that the "Now Playing" heading is displayed correctly
    expect(find.text('Failed'), findsNWidgets(3));
  });
}
