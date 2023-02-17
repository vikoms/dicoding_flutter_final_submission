part of 'series_home_bloc.dart';

@immutable
abstract class SeriesHomeEvent extends Equatable {}

class OnGetNowPlayingSeriesHome extends SeriesHomeEvent {
  OnGetNowPlayingSeriesHome();
  @override
  List<Object?> get props => [];
}

class OnGetPopularSeriesHome extends SeriesHomeEvent {
  OnGetPopularSeriesHome();
  @override
  List<Object?> get props => [];
}
