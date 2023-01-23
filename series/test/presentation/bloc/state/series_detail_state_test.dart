import 'package:flutter_test/flutter_test.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/presentation/bloc/series_detail/series_detail_bloc.dart';

import '../../../helpers/dummy_data.dart';

void main() {
  test('OnGetSeriesDetail should have correct seriesId', () {
    final OnGetSeriesDetail event = OnGetSeriesDetail(123);
    expect(event.seriesId, 123);
    expect(event.props, [123]);
  });

  test('OnAddSeriesWatchlist should have correct series', () {
    final OnAddSeriesWatchlist event = OnAddSeriesWatchlist(testSeriesDetail);

    expect(event.series, testSeriesDetail);
    expect(event.props, [testSeriesDetail]);
  });

  test('OnRemoveSeriesWatchlist should have correct series', () {
    final OnRemoveSeriesWatchlist event =
        OnRemoveSeriesWatchlist(testSeriesDetail);

    expect(event.series, testSeriesDetail);
    expect(event.props, [testSeriesDetail]);
  });

  test('OnGetWatchlistStatus should have correct seriesId', () {
    final OnGetWatchlistStatus event = OnGetWatchlistStatus(123);

    expect(event.seriesId, 123);
    expect(event.props, [123]);
  });
}
