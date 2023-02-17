import 'package:core/core.dart';
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
  final NetworkInfo networkInfo;
  NowPlayingSeriesBloc(
    this.getNowPlayingSeries,
    this.networkInfo,
  ) : super(NowPlayingSeriesInitial()) {
    int page = 1;
    on<OnGetNowPlayingSeries>((event, emit) async {
      page = 1;
      emit(NowPlayingSeriesLoading());
      var result = await getNowPlayingSeries.execute();
      result.fold((error) {
        emit(
          NowPlayingSeriesError(error.message),
        );
      }, (series) {
        page++;
        emit(
          NowPlayingSeriesLoaded(
            nowPlayingSeries: series,
          ),
        );
      });
    });

    on<OnGetMoreNowPlayingSeries>((event, emit) async {
      try {
        bool isConnected = await networkInfo.isConnected;
        if (!isConnected) {
          return;
        }
        if (state is! NowPlayingSeriesLoaded) {
          return;
        }
        final currentState = state as NowPlayingSeriesLoaded;

        if (currentState.pagingState == RequestState.Loading ||
            currentState.hasReachedMax) {
          return;
        }

        emit(currentState.copyWith(pagingState: RequestState.Loading));

        final result = await getNowPlayingSeries.execute(
          page: page,
        );

        result.fold((error) {
          emit(currentState.copyWith(pagingState: RequestState.Error));
        }, (newMovies) {
          page++;
          emit(currentState.copyWith(
            hasReachedMax: newMovies.isEmpty,
            newSeries: List.of(currentState.nowPlayingSeries)
              ..addAll(newMovies),
            pagingState: RequestState.Loaded,
          ));
        });
      } catch (e) {
        if (state is NowPlayingSeriesLoaded) {
          emit(
            (state as NowPlayingSeriesLoaded).copyWith(
              pagingState: RequestState.Error,
              message: e.toString(),
            ),
          );
        }
      }
    });
  }
}
