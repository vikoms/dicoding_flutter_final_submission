import 'package:bloc/bloc.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';

part 'series_home_event.dart';
part 'series_home_state.dart';

class SeriesHomeBloc extends Bloc<SeriesHomeEvent, SeriesHomeState> {
  final GetPopularSeries getPopularSeries;
  final GetNowPlayingSeries getNowPlayingSeries;
  SeriesHomeBloc(
    this.getPopularSeries,
    this.getNowPlayingSeries,
  ) : super(SeriesHomeState()) {
    on<OnGetNowPlayingSeriesHome>((event, emit) async {
      emit(state.copyWith(
        nowPlayingState: RequestState.Loading,
      ));

      final result = await getNowPlayingSeries.execute();
      result.fold((error) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          nowPlayingMessage: error.message,
        ));
      }, (series) {
        emit(state.copyWith(
          nowPlayingSeries: series,
          nowPlayingState: RequestState.Loaded,
        ));
      });
    });

    on<OnGetPopularSeriesHome>((event, emit) async {
      emit(state.copyWith(
        popularState: RequestState.Loading,
      ));

      final result = await getPopularSeries.execute();
      result.fold((error) {
        emit(state.copyWith(
          popularState: RequestState.Error,
          popularMessage: error.message,
        ));
      }, (series) {
        emit(state.copyWith(
          popularSeries: series,
          popularState: RequestState.Loaded,
        ));
      });
    });
  }
}
