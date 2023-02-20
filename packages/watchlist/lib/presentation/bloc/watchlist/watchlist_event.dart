part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetWatchlist extends WatchlistEvent {
  OnGetWatchlist();
  @override
  List<Object?> get props => [];
}
