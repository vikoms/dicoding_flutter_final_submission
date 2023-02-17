import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/usecases/get_popular_series.dart';

import '../../../domain/entities/series.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries getPopularSeries;
  final NetworkInfo networkInfo;
  PopularSeriesBloc(
    this.getPopularSeries,
    this.networkInfo,
  ) : super(PopularSeriesInitial()) {
    int page = 1;
    on<OnGetPopularSeries>((event, emit) async {
      page = 1;
      emit(PopularSeriesLoading());
      var result = await getPopularSeries.execute();
      result.fold((error) {
        emit(PopularSeriesError(error.message));
      }, (series) {
        page++;
        emit(PopularSeriesLoaded(popularSeries: series));
      });
    });

    on<OnGetMorePopularSeries>((event, emit) async {
      try {
        bool isConnected = await networkInfo.isConnected;
        if (!isConnected) {
          return;
        }
        if (state is! PopularSeriesLoaded) {
          return;
        }
        final currentState = state as PopularSeriesLoaded;

        if (currentState.pagingState == RequestState.Loading ||
            currentState.hasReachedMax) {
          return;
        }

        emit(currentState.copyWith(pagingState: RequestState.Loading));

        final result = await getPopularSeries.execute(
          page: page,
        );

        result.fold((error) {
          emit(currentState.copyWith(pagingState: RequestState.Error));
        }, (newMovies) {
          page++;
          emit(currentState.copyWith(
            hasReachedMax: newMovies.isEmpty,
            newSeries: List.of(currentState.popularSeries)..addAll(newMovies),
            pagingState: RequestState.Loaded,
          ));
        });
      } catch (e) {
        if (state is PopularSeriesLoaded) {
          emit(
            (state as PopularSeriesLoaded).copyWith(
              pagingState: RequestState.Error,
              message: e.toString(),
            ),
          );
        }
      }
    });
  }
}
