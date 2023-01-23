part of 'now_playing_series_bloc.dart';

@immutable
abstract class NowPlayingSeriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetNowPlayingSeries extends NowPlayingSeriesEvent {
  OnGetNowPlayingSeries();

  @override
  List<Object?> get props => [];
}
