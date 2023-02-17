part of 'popular_series_bloc.dart';

@immutable
abstract class PopularSeriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetPopularSeries extends PopularSeriesEvent {
  OnGetPopularSeries();

  @override
  List<Object?> get props => [];
}

class OnGetMorePopularSeries extends PopularSeriesEvent {
  OnGetMorePopularSeries();

  @override
  List<Object?> get props => [];
}
