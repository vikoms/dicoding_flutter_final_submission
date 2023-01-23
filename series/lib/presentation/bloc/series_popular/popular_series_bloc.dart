import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:series/domain/usecases/get_popular_series.dart';

import '../../../domain/entities/series.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries getPopularSeries;
  PopularSeriesBloc(this.getPopularSeries) : super(PopularSeriesInitial()) {
    on<OnGetPopularSeries>((event, emit) async {
      emit(PopularSeriesLoading());
      var result = await getPopularSeries.execute();
      result.fold(
        (error) => emit(
          PopularSeriesError(error.message),
        ),
        (series) => emit(
          PopularSeriesLoaded(series),
        ),
      );
    });
  }
}
