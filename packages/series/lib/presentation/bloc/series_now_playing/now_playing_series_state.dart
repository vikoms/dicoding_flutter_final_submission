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
  final List<Series> nowPlayingSeries;
  bool hasReachedMax;
  RequestState pagingState;
  String message;
  NowPlayingSeriesLoaded({
    required this.nowPlayingSeries,
    this.hasReachedMax = false,
    this.pagingState = RequestState.Empty,
    this.message = '',
  });

  NowPlayingSeriesLoaded copyWith({
    List<Series>? newSeries,
    bool hasReachedMax = false,
    RequestState pagingState = RequestState.Empty,
    String message = '',
  }) {
    return NowPlayingSeriesLoaded(
      nowPlayingSeries: newSeries ?? nowPlayingSeries,
      hasReachedMax: hasReachedMax,
      pagingState: pagingState,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingSeries,
        hasReachedMax,
        pagingState,
        message,
      ];
}
