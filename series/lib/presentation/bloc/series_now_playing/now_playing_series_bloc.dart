import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';

part 'now_playing_series_event.dart';
part 'now_playing_series_state.dart';

class NowPlayingSeriesBloc
    extends Bloc<NowPlayingSeriesEvent, NowPlayingSeriesState> {
  final GetNowPlayingSeries getNowPlayingSeries;

  NowPlayingSeriesBloc(this.getNowPlayingSeries)
      : super(NowPlayingSeriesInitial()) {
    on<OnGetNowPlayingSeries>((event, emit) async {
      emit(NowPlayingSeriesLoading());
      var result = await getNowPlayingSeries.execute();
      result.fold(
        (error) => emit(
          NowPlayingSeriesError(error.message),
        ),
        (series) => emit(
          NowPlayingSeriesLoaded(series),
        ),
      );
    });
  }
}
