import 'package:core/domain/entities/series.dart';
import 'package:core/presentation/pages/home_series_page.dart';
import 'package:core/presentation/provider/series_list_notifier.dart';
import 'package:core/presentation/widgets/item_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_series_page_test.mocks.dart';

@GenerateMocks([SeriesListNotifier])
void main() {
  late MockSeriesListNotifier mockNotifier;
  setUp(() {
    mockNotifier = MockSeriesListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SeriesListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'SeriesHomePage displays Series lists and headings correctly when data is loaded',
      (WidgetTester tester) async {
    // Stub the state properties to return the RequestState.Loaded value
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedState).thenReturn(RequestState.Loaded);
    when(mockNotifier.nowPlayingSeries).thenReturn(<Series>[]);
    when(mockNotifier.topRatedSeries).thenReturn(<Series>[]);
    when(mockNotifier.popularSeries).thenReturn(<Series>[]);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeSeriesPage(),
      ),
    );

    // Verify that the "Now Playing" heading is displayed correctly
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.byType(ItemList), findsNWidgets(3));
  });

  testWidgets(
      'SeriesHomePage displays progress bar and headings correctly when data is loading',
      (WidgetTester tester) async {
    // Stub the state properties to return the RequestState.Loaded value
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loading);
    when(mockNotifier.popularState).thenReturn(RequestState.Loading);
    when(mockNotifier.topRatedState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeSeriesPage(),
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
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Error);
    when(mockNotifier.popularState).thenReturn(RequestState.Error);
    when(mockNotifier.topRatedState).thenReturn(RequestState.Error);

    await tester.pumpWidget(
      _makeTestableWidget(
        HomeSeriesPage(),
      ),
    );

    // Verify that the "Now Playing" heading is displayed correctly
    expect(find.text('Failed'), findsNWidgets(3));
  });
}
