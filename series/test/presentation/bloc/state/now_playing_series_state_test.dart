import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/bloc/series_now_playing/now_playing_series_bloc.dart';

void main() {
  test('OnGetNowPlayingSeries should have correct props', () {
    final OnGetNowPlayingSeries event = OnGetNowPlayingSeries();
    expect(event.props, []);
  });
}
