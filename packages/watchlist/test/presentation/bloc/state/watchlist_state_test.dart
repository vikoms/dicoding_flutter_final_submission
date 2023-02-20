import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_bloc.dart';

void main() {
  test('OnGetWatchlist should have correct props', () {
    final OnGetWatchlist event = OnGetWatchlist();
    expect(event.props, []);
  });
}
