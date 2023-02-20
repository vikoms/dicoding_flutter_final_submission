part of 'series_home_bloc.dart';

@immutable
class SeriesHomeState extends Equatable {
  final List<Series> nowPlayingSeries;
  final List<Series> popularSeries;

  final RequestState nowPlayingState;
  final RequestState popularState;

  final String nowPlayingMessage;
  final String popularMessage;

  const SeriesHomeState({
    this.nowPlayingSeries = const [],
    this.popularSeries = const [],
    this.nowPlayingState = RequestState.Empty,
    this.popularState = RequestState.Empty,
    this.nowPlayingMessage = '',
    this.popularMessage = '',
  });

  SeriesHomeState copyWith({
    List<Series>? nowPlayingSeries,
    List<Series>? popularSeries,
    RequestState? nowPlayingState,
    RequestState? popularState,
    String? nowPlayingMessage,
    String? popularMessage,
  }) =>
      SeriesHomeState(
        nowPlayingSeries: nowPlayingSeries ?? this.nowPlayingSeries,
        popularSeries: popularSeries ?? this.popularSeries,
        nowPlayingState: nowPlayingState ?? this.nowPlayingState,
        popularState: popularState ?? this.popularState,
        nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
        popularMessage: popularMessage ?? this.popularMessage,
      );

  @override
  List<Object?> get props => [
        nowPlayingSeries,
        popularSeries,
        nowPlayingState,
        popularState,
        nowPlayingMessage,
        popularMessage,
      ];
}

class SeriesHomeInitial extends SeriesHomeState {}
