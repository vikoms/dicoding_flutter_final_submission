import 'package:core/core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'series_list_page_test.mocks.dart';

@GenerateMocks([SingleSeriesListNotifier])
void main() {
  late MockSingleSeriesListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSingleSeriesListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SingleSeriesListNotifier>.value(
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
        SeriesListPage(
          arguments: SeriesListArguments("Series", SeriesListEnum.Popular),
        ),
      ),
    );

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.listSeries).thenReturn(<Series>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      _makeTestableWidget(
        SeriesListPage(
          arguments: SeriesListArguments("Series", SeriesListEnum.Popular),
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
        SeriesListPage(
          arguments: SeriesListArguments("Series", SeriesListEnum.Popular),
        ),
      ),
    );

    expect(textFinder, findsOneWidget);
  });
}
