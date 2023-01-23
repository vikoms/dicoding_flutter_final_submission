import 'package:bloc/bloc.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

import '../../../domain/entities/series.dart';
import '../../../domain/usecases/get_series_recommendations.dart';
import '../../../domain/usecases/remove_watchlist_series.dart';
import '../../../domain/usecases/save_watchlist_series.dart';

part 'series_detail_event.dart';
part 'series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  static const watchListAddSuccessMessage = "Added to Watchlist";
  static const watchListRemoveSuccessMessage = "Removed from Watchlist";

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final SaveWatchlistSeries saveWatchListSeries;
  final GetWatchlistStatus getWatchListStatus;
  final RemoveWatchlistSeries removeWatchlist;
  SeriesDetailBloc(
    this.getSeriesDetail,
    this.getWatchListStatus,
    this.saveWatchListSeries,
    this.removeWatchlist,
    this.getSeriesRecommendations,
  ) : super(SeriesDetailState.initial()) {
    on<OnGetSeriesDetail>((event, emit) async {
      emit(state.copyWith(seriesState: RequestState.Loading));
      var result = await getSeriesDetail.execute(event.seriesId);
      var recommendations =
          await getSeriesRecommendations.execute(event.seriesId);

      result.fold(
        (error) => emit(state.copyWith(
          message: error.message,
          seriesState: RequestState.Error,
        )),
        (series) {
          recommendations.fold(
            (error) => emit(
              state.copyWith(
                message: error.message,
                seriesState: RequestState.Error,
              ),
            ),
            (listSeries) => emit(
              state.copyWith(
                series: series,
                recommendationSeries: listSeries,
                seriesState: RequestState.Loaded,
              ),
            ),
          );
        },
      );
    });

    on<OnGetWatchlistStatus>((event, emit) async {
      var result = await getWatchListStatus.execute(event.seriesId);
      emit(
        state.copyWith(isAddedWatchlist: result),
      );
    });

    on<OnAddSeriesWatchlist>((event, emit) async {
      var result = await saveWatchListSeries.execute(event.series);
      result.fold(
        (l) => emit(
          state.copyWith(watchlistMessage: l.message),
        ),
        (successMessage) {
          emit(state.copyWith(
            watchlistMessage: successMessage,
            isAddedWatchlist: true,
          ));
        },
      );
    });

    on<OnRemoveSeriesWatchlist>((event, emit) async {
      var result = await removeWatchlist.execute(event.series);
      result.fold(
        (l) => emit(
          state.copyWith(watchlistMessage: l.message),
        ),
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
          add(OnGetWatchlistStatus(event.series.id));
        },
      );
    });
  }
}
