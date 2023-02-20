import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist getWatchlist;
  WatchlistBloc(this.getWatchlist) : super(WatchlistState()) {
    on<OnGetWatchlist>((event, emit) async {
      final result = await getWatchlist.execute();
      result.fold(
        (error) => emit(
          state.copyWith(state: RequestState.Error, message: error.message),
        ),
        (watchlist) => emit(
          state.copyWith(watchlist: watchlist, state: RequestState.Loaded),
        ),
      );
    });
  }
}
