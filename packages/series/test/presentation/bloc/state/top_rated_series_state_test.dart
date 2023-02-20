import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/bloc/series_top_rated/top_rated_series_bloc.dart';

void main() {
  test('OnGetTopRatedSeries should have correct props', () {
    final OnGetTopRatedSeries event = OnGetTopRatedSeries();
    expect(event.props, []);
  });
}
