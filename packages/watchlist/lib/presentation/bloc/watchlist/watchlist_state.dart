part of 'watchlist_bloc.dart';

@immutable
class WatchlistState extends Equatable {
  final RequestState watchlistState;
  final List<Watchlist> watchlist;
  final String message;

  const WatchlistState({
    this.watchlistState = RequestState.Empty,
    this.watchlist = const [],
    this.message = '',
  });

  WatchlistState copyWith({
    RequestState? state,
    List<Watchlist>? watchlist,
    String? message,
  }) {
    return WatchlistState(
      watchlistState: state ?? this.watchlistState,
      watchlist: watchlist ?? this.watchlist,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        watchlistState,
        watchlist,
        message,
      ];
}
