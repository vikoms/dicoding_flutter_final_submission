import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/bloc/series_popular/popular_series_bloc.dart';

void main() {
  test('OnGetPopularSeries should have correct props', () {
    final OnGetPopularSeries event = OnGetPopularSeries();
    expect(event.props, []);
  });
}
