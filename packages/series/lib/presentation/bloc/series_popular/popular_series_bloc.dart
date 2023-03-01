import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/usecases/get_popular_series.dart';

import '../../../domain/entities/series.dart';
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
    int _page = 1;
    bool _hasNextPage = true;
    on<OnGetPopularSeries>((event, emit) async {
      final isConnected = await networkInfo.isConnected;
      if (_hasNextPage) {
        try {
          if (state is PopularSeriesInitial) {
            emit(PopularSeriesLoading());
            final seriesInit = await getPopularSeries.execute();
            seriesInit.fold((error) {
              emit(PopularSeriesError(errorMessage: error.message));
            }, (series) {
              emit(
                PopularSeriesLoaded(
                  series: series,
                  hasReachedMax: false,
                ),
              );
            });
          } else if (state is PopularSeriesLoaded && isConnected) {
            _page++;
            final moreSerries = await getPopularSeries.execute(page: _page);
            moreSerries.fold((error) {
              emit(
                PopularSeriesError(
                  errorMessage: error.message,
                ),
              );
            }, (series) {
              if (series.isEmpty) {
                _hasNextPage = false;
                emit((state as PopularSeriesLoaded)
                    .copyWith(hasReachedMax: true));
              } else {
                emit(PopularSeriesLoaded(
                  series: (state as PopularSeriesLoaded).series + series,
                  hasReachedMax: false,
                ));
              }
            });
          }
        } catch (ex) {
          emit(
            PopularSeriesError(
              errorMessage: ex.toString(),
            ),
          );
        }
      }
    }, transformer: Utils.debounce(const Duration(milliseconds: 500)));
  }
}
