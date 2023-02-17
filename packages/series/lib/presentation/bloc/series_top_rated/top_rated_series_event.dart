part of 'top_rated_series_bloc.dart';

@immutable
abstract class TopRatedSeriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetTopRatedSeries extends TopRatedSeriesEvent {
  OnGetTopRatedSeries();

  @override
  List<Object?> get props => [];
}