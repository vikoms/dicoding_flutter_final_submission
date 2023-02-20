part of 'popular_series_bloc.dart';

@immutable
abstract class PopularSeriesState extends Equatable {
  const PopularSeriesState();

  @override
  List<Object?> get props => [];
}

class PopularSeriesInitial extends PopularSeriesState {}

class PopularSeriesLoading extends PopularSeriesState {}

class PopularSeriesError extends PopularSeriesState {
  final String errorMessage;

  const PopularSeriesError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class PopularSeriesLoaded extends PopularSeriesState {
  final List<Series> series;
  final bool hasReachedMax;

  const PopularSeriesLoaded({
    required this.series,
    this.hasReachedMax = false,
  });

  PopularSeriesLoaded copyWith({
    List<Series>? series,
    bool? hasReachedMax,
  }) {
    return PopularSeriesLoaded(
      series: series ?? this.series,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [series, hasReachedMax];
}
