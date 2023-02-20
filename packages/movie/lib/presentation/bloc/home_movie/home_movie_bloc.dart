import 'package:bloc/bloc.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'home_movie_event.dart';
part 'home_movie_state.dart';

class HomeMovieBloc extends Bloc<HomeMovieEvent, HomeMovieState> {
  final GetPopularMovies getPopularMovie;
  final GetNowPlayingMovies getNowPlayingMovies;
  HomeMovieBloc(
    this.getNowPlayingMovies,
    this.getPopularMovie,
  ) : super(HomeMovieState()) {
    on<OnGetNowPlayingMovie>((event, emit) async {
      emit(state.copyWith(
        nowPlayingState: RequestState.Loading,
      ));

      final result = await getNowPlayingMovies.execute();
      result.fold((error) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          nowPlayingMessage: error.message,
        ));
      }, (movies) {
        emit(state.copyWith(
          nowPlayingMovies: movies,
          nowPlayingState: RequestState.Loaded,
        ));
      });
    });

    on<OnGetPopularMovie>((event, emit) async {
      emit(state.copyWith(
        popularState: RequestState.Loading,
      ));

      final result = await getPopularMovie.execute();
      result.fold((error) {
        emit(state.copyWith(
          popularState: RequestState.Error,
          popularMessage: error.message,
        ));
      }, (movies) {
        emit(state.copyWith(
          popularMovies: movies,
          popularState: RequestState.Loaded,
        ));
      });
    });
  }
}
