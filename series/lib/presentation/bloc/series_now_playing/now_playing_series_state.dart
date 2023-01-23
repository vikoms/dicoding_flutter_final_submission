part of 'now_playing_series_bloc.dart';

@immutable
abstract class NowPlayingSeriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingSeriesInitial extends NowPlayingSeriesState {}

class NowPlayingSeriesLoading extends NowPlayingSeriesState {}

class NowPlayingSeriesError extends NowPlayingSeriesState {
  String errorMessage;
  NowPlayingSeriesError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class NowPlayingSeriesLoaded extends NowPlayingSeriesState {
  List<Series> nowPlayingSeries;
  NowPlayingSeriesLoaded(this.nowPlayingSeries);

  @override
  List<Object?> get props => [nowPlayingSeries];
}
