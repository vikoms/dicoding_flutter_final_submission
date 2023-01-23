import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

import '../../../domain/entities/movie.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMovieInitial()) {
    on<OnGetNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (error) => emit(
          NowPlayingMoviesError(error.message),
        ),
        (movies) => emit(
          NowPlayingMoviesLoaded(movies),
        ),
      );
    });
  }
}
