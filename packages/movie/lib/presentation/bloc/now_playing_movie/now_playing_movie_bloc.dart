import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

import '../../../domain/entities/movie.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final NetworkInfo networkInfo;
  NowPlayingMovieBloc(
    this.getNowPlayingMovies,
    this.networkInfo,
  ) : super(NowPlayingMovieInitial()) {
    int page = 1;
    on<OnGetNowPlayingMovies>((event, emit) async {
      page = 1;
      emit(NowPlayingMoviesLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold((error) {
        emit(NowPlayingMoviesError(error.message));
      }, (movies) {
        page++;
        emit(NowPlayingMoviesLoaded(movies: movies));
      });
    });

    on<OnGetMoreNowPlayingMovies>((event, emit) async {
      bool isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        return;
      }
      if (state is! NowPlayingMoviesLoaded) {
        return;
      }
      final currentState = state as NowPlayingMoviesLoaded;

      if (currentState.pagingState == RequestState.Loading ||
          currentState.hasReachedMax) {
        return;
      }
      emit((state as NowPlayingMoviesLoaded)
          .copyWith(pagingState: RequestState.Loading));

      final result = await getNowPlayingMovies.execute(
        page: page,
      );

      result.fold((error) {
        emit((state as NowPlayingMoviesLoaded)
            .copyWith(pagingState: RequestState.Error, message: error.message));
      }, (newMovies) {
        page++;
        emit((state as NowPlayingMoviesLoaded).copyWith(
          hasReachedMax: newMovies.isEmpty,
          newMovies: List.of(currentState.movies)..addAll(newMovies),
          pagingState: RequestState.Loaded,
        ));
      });
    });
  }
}
