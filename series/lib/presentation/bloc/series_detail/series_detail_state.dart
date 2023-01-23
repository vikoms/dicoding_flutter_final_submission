part of 'series_detail_bloc.dart';

@immutable
class SeriesDetailState extends Equatable {
  final SeriesDetail? series;
  final List<Series> recommendationSeries;
  final bool isAddedWatchlist;
  final String watchlistMessage;
  final RequestState seriesState;
  final String message;

  // const SeriesDetailState({
  //   this.series,
  //   this.watchlistMessage = '',
  //   this.message = '',
  //   this.recommendationSeries = const [],
  //   this.isAddedWatchlist = false,
  //   this.seriesState = RequestState.Loading,
  // });

  const SeriesDetailState({
    required this.series,
    required this.recommendationSeries,
    required this.isAddedWatchlist,
    required this.watchlistMessage,
    required this.seriesState,
    required this.message,
  });

  factory SeriesDetailState.initial() => const SeriesDetailState(
        series: null,
        recommendationSeries: [],
        isAddedWatchlist: false,
        watchlistMessage: '',
        seriesState: RequestState.Loading,
        message: '',
      );

  SeriesDetailState copyWith({
    SeriesDetail? series,
    List<Series>? recommendationSeries,
    bool? isAddedWatchlist,
    String? watchlistMessage,
    RequestState? seriesState,
    String? message,
  }) {
    return SeriesDetailState(
      series: series ?? this.series,
      recommendationSeries: recommendationSeries ?? this.recommendationSeries,
      isAddedWatchlist: isAddedWatchlist ?? this.isAddedWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      seriesState: seriesState ?? this.seriesState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        series,
        recommendationSeries,
        isAddedWatchlist,
        seriesState,
        watchlistMessage,
        message,
      ];
}
