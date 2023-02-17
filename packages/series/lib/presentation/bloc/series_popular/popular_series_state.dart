part of 'popular_series_bloc.dart';

@immutable
abstract class PopularSeriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularSeriesInitial extends PopularSeriesState {}

class PopularSeriesLoading extends PopularSeriesState {}

class PopularSeriesError extends PopularSeriesState {
  String errorMessage;
  PopularSeriesError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class PopularSeriesLoaded extends PopularSeriesState {
  final List<Series> popularSeries;
  bool hasReachedMax;
  RequestState pagingState;
  String message;
  PopularSeriesLoaded({
    required this.popularSeries,
    this.hasReachedMax = false,
    this.pagingState = RequestState.Empty,
    this.message = '',
  });

  PopularSeriesLoaded copyWith({
    List<Series>? newSeries,
    bool hasReachedMax = false,
    RequestState pagingState = RequestState.Empty,
    String message = '',
  }) {
    return PopularSeriesLoaded(
      popularSeries: newSeries ?? popularSeries,
      hasReachedMax: hasReachedMax,
      pagingState: pagingState,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        popularSeries,
        hasReachedMax,
        pagingState,
        message,
      ];
}
