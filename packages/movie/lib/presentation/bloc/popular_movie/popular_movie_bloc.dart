import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

import '../../../domain/entities/movie.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  final NetworkInfo networkInfo;
  PopularMovieBloc(
    this.getPopularMovies,
    this.networkInfo,
  ) : super(PopularMovieInitial()) {
    int page = 1;
    on<OnGetPopularMovies>((event, emit) async {
      page = 1;
      emit(PopularMovieLoading());
      final result = await getPopularMovies.execute();
      result.fold((error) {
        emit(
          PopularMovieError(error.message),
        );
      }, (movies) {
        page++;
        emit(
          PopularMovieLoaded(
            movies: movies,
          ),
        );
      });
    });

    on<OnGetMorePopularMovies>((event, emit) async {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return;
      }
      if (state is! PopularMovieLoaded) {
        return;
      }

      final currentState = state as PopularMovieLoaded;
      if (currentState.hasReachedMax ||
          currentState.pagingState == RequestState.Loading) {
        return;
      }

      emit(currentState.copyWith(pagingState: RequestState.Loading));
      final result = await getPopularMovies.execute(page: page);
      result.fold((error) {
        emit(
          currentState.copyWith(
            pagingState: RequestState.Error,
            message: error.message,
          ),
        );
      }, (movies) {
        page++;
        emit(currentState.copyWith(
          movies: List.of(currentState.movies)..addAll(movies),
          hasReachedMax: movies.isEmpty,
          pagingState: RequestState.Loaded,
        ));
      });
    });
  }
}
