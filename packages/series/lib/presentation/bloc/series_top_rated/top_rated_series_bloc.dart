import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/series.dart';
import '../../../domain/usecases/get_top_rated_series.dart';

part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries getTopRatedSeries;
  TopRatedSeriesBloc(this.getTopRatedSeries) : super(TopRatedSeriesInitial()) {
    on<OnGetTopRatedSeries>((event, emit) async {
      emit(TopRatedSeriesLoading());
      var result = await getTopRatedSeries.execute();
      result.fold(
        (error) => emit(
          TopRatedSeriesError(error.message),
        ),
        (series) => emit(
          TopRatedSeriesLoaded(series),
        ),
      );
    });
  }
}
