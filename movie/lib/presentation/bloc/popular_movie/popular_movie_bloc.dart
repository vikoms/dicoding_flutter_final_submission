import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

import '../../../domain/entities/movie.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieBloc(this.getPopularMovies) : super(PopularMovieInitial()) {
    on<OnGetPopularMovies>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (error) => emit(
          PopularMovieError(error.message),
        ),
        (movies) => emit(
          PopularMovieLoaded(movies),
        ),
      );
    });
  }
}
