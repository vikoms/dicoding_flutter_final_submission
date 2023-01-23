import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

import '../../../domain/entities/movie.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMovieBloc(this.getTopRatedMovies) : super(TopRatedMovieInitial()) {
    on<OnGetTopRatedMovies>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (error) => emit(
          TopRatedMovieError(error.message),
        ),
        (movies) => emit(
          TopRatedMovieLoaded(movies),
        ),
      );
    });
  }
}
