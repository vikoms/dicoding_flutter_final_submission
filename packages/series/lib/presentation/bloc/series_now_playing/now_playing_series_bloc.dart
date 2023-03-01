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
    int _page = 1;
    bool _hasNextPage = true;
    on<OnGetNowPlayingSeries>((event, emit) async {
      final isConnected = await networkInfo.isConnected;
      if (_hasNextPage) {
        try {
          if (state is NowPlayingSeriesInitial) {
            emit(NowPlayingSeriesLoading());
            final seriesInit = await getNowPlayingSeries.execute();
            seriesInit.fold((error) {
              emit(NowPlayingSeriesError(errorMessage: error.message));
            }, (series) {
              emit(
                NowPlayingSeriesLoaded(
                  series: series,
                  hasReachedMax: false,
                ),
              );
            });
          } else if (state is NowPlayingSeriesLoaded && isConnected) {
            _page++;
            final moreSerries = await getNowPlayingSeries.execute(page: _page);
            moreSerries.fold((error) {
              emit(
                NowPlayingSeriesError(
                  errorMessage: error.message,
                ),
              );
            }, (series) {
              if (series.isEmpty) {
                _hasNextPage = false;
                emit((state as NowPlayingSeriesLoaded)
                    .copyWith(hasReachedMax: true));
              } else {
                emit(NowPlayingSeriesLoaded(
                  series: (state as NowPlayingSeriesLoaded).series + series,
                  hasReachedMax: false,
                ));
              }
            });
          }
        } catch (ex) {
          emit(
            NowPlayingSeriesError(
              errorMessage: ex.toString(),
            ),
          );
        }
      }
    }, transformer: Utils.debounce(const Duration(milliseconds: 500)));
  }
}
