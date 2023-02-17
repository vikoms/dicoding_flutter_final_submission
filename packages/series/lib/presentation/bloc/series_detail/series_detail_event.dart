part of 'series_detail_bloc.dart';

@immutable
abstract class SeriesDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetSeriesDetail extends SeriesDetailEvent {
  final int seriesId;
  OnGetSeriesDetail(this.seriesId);
  @override
  List<Object?> get props => [seriesId];
}

class OnAddSeriesWatchlist extends SeriesDetailEvent {
  final SeriesDetail series;
  OnAddSeriesWatchlist(this.series);

  @override
  List<Object?> get props => [series];
}

class OnRemoveSeriesWatchlist extends SeriesDetailEvent {
  final SeriesDetail series;
  OnRemoveSeriesWatchlist(this.series);
  @override
  List<Object?> get props => [series];
}

class OnGetWatchlistStatus extends SeriesDetailEvent {
  final int seriesId;
  OnGetWatchlistStatus(this.seriesId);
  @override
  List<Object?> get props => [seriesId];
}
