import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movie_list_page.dart';
import 'package:core/presentation/provider/single_movie_list_notifier.dart';
import 'package:core/utils/movie_list_enum.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'movie_list_page_test.mocks.dart';

@GenerateMocks([SingleMovieListNotifier])
void main() {
  late MockSingleMovieListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSingleMovieListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SingleMovieListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
      _makeTestableWidget(
        MovieListPage(
          params: MovieListArguments("Now Playing", MovieListEnum.NowPlaying),
        ),
      ),
    );

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      _makeTestableWidget(
        MovieListPage(
          params: MovieListArguments("Now Playing", MovieListEnum.NowPlaying),
        ),
      ),
    );

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(
      _makeTestableWidget(
        MovieListPage(
          params: MovieListArguments("Now Playing", MovieListEnum.NowPlaying),
        ),
      ),
    );

    expect(textFinder, findsOneWidget);
  });
}
