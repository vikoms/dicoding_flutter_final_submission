part of 'now_playing_series_bloc.dart';

@immutable
abstract class NowPlayingSeriesState extends Equatable {
  const NowPlayingSeriesState();

  @override
  List<Object?> get props => [];
}

class NowPlayingSeriesInitial extends NowPlayingSeriesState {}

class NowPlayingSeriesLoading extends NowPlayingSeriesState {}

class NowPlayingSeriesError extends NowPlayingSeriesState {
  final String errorMessage;

  const NowPlayingSeriesError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class NowPlayingSeriesLoaded extends NowPlayingSeriesState {
  final List<Series> series;
  final bool hasReachedMax;

  const NowPlayingSeriesLoaded({
    required this.series,
    this.hasReachedMax = false,
  });

  NowPlayingSeriesLoaded copyWith({
    List<Series>? series,
    bool? hasReachedMax,
  }) {
    return NowPlayingSeriesLoaded(
      series: series ?? this.series,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [series, hasReachedMax];
}
