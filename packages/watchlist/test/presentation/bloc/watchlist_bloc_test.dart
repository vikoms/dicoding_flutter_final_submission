import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_bloc.dart';

import '../../dummy_data/dummy_data.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlist,
])
void main() {
  late MockGetWatchlist getWatchlist;
  late WatchlistBloc watchlistBloc;

  setUp(() {
    getWatchlist = MockGetWatchlist();
    watchlistBloc = WatchlistBloc(getWatchlist);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistState());
  });

  final tWatchlist = <Watchlist>[testMovieWatchList];

  blocTest<WatchlistBloc, WatchlistState>(
    'emits [Loaded] when OnGetWatchlist got successfully.',
    build: () {
      when(getWatchlist.execute()).thenAnswer((_) async => Right(tWatchlist));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlist()),
    expect: () => <WatchlistState>[
      WatchlistState()
          .copyWith(state: RequestState.Loaded, watchlist: tWatchlist),
    ],
    verify: (bloc) => verify(
      getWatchlist.execute(),
    ),
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'emits [Error] when OnGetWatchlist got failure.',
    build: () {
      when(getWatchlist.execute())
          .thenAnswer((_) async => Left(ServerFailure('Error')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlist()),
    expect: () => <WatchlistState>[
      WatchlistState().copyWith(state: RequestState.Error, message: 'Error'),
    ],
    verify: (bloc) => verify(
      getWatchlist.execute(),
    ),
  );
}
