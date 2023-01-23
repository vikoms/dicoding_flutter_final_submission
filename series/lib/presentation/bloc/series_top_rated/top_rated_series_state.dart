part of 'top_rated_series_bloc.dart';

@immutable
abstract class TopRatedSeriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRatedSeriesInitial extends TopRatedSeriesState {}

class TopRatedSeriesLoading extends TopRatedSeriesState {}

class TopRatedSeriesError extends TopRatedSeriesState {
  String errorMessage;
  TopRatedSeriesError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class TopRatedSeriesLoaded extends TopRatedSeriesState {
  List<Series> topRatedSeries;
  TopRatedSeriesLoaded(this.topRatedSeries);

  @override
  List<Object?> get props => [topRatedSeries];
}
