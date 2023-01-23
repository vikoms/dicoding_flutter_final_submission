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
  List<Series> popularSeries;
  PopularSeriesLoaded(this.popularSeries);

  @override
  List<Object?> get props => [popularSeries];
}
