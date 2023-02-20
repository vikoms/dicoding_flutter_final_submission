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
    int _page = 1;
    bool _hasNextPage = true;
    // on<OnGetNowPlayingMovies>((event, emit) async {
    //   page = 1;
    //   emit(NowPlayingMoviesLoading());
    //   final result = await getNowPlayingMovies.execute();

    //   result.fold((error) {
    //     emit(NowPlayingMoviesError(error.message));
    //   }, (movies) {
    //     page++;
    //     emit(NowPlayingMoviesLoaded(movies: movies));
    //   });
    // });

    // on<OnGetMoreNowPlayingMovies>((event, emit) async {
    //   bool isConnected = await networkInfo.isConnected;
    //   if (!isConnected) {
    //     return;
    //   }
    //   if (state is! NowPlayingMoviesLoaded) {
    //     return;
    //   }
    //   final currentState = state as NowPlayingMoviesLoaded;

    //   if (currentState.pagingState == RequestState.Loading ||
    //       currentState.hasReachedMax) {
    //     return;
    //   }
    //   emit((state as NowPlayingMoviesLoaded)
    //       .copyWith(pagingState: RequestState.Loading));

    //   final result = await getNowPlayingMovies.execute(
    //     page: page,
    //   );

    //   result.fold((error) {
    //     emit((state as NowPlayingMoviesLoaded)
    //         .copyWith(pagingState: RequestState.Error, message: error.message));
    //   }, (newMovies) {
    //     page++;
    //     emit((state as NowPlayingMoviesLoaded).copyWith(
    //       hasReachedMax: newMovies.isEmpty,
    //       newMovies: List.of(currentState.movies)..addAll(newMovies),
    //       pagingState: RequestState.Loaded,
    //     ));
    //   });
    // });

    on<OnGetNowPlayingMovies>((event, emit) async {
      final isConnected = await networkInfo.isConnected;
      if (_hasNextPage) {
        try {
          if (state is NowPlayingMovieInitial) {
            emit(NowPlayingMovieLoading());
            final movieInit = await getNowPlayingMovies.execute();
            movieInit.fold((error) {
              emit(NowPlayingMovieError(errorMessage: error.message));
            }, (movies) {
              emit(NowPlayingMovieLoaded(
                movies: movies,
                hasReachedMax: false,
              ));
            });
          } else if (state is NowPlayingMovieLoaded && isConnected) {
            _page++;
            final moreMovies = await getNowPlayingMovies.execute(page: _page);
            moreMovies.fold((error) {
              emit(
                NowPlayingMovieError(
                  errorMessage: error.message,
                ),
              );
            }, (movies) {
              if (movies.isEmpty) {
                _hasNextPage = false;
                emit((state as NowPlayingMovieLoaded)
                    .copyWith(hasReachedMax: true));
              } else {
                emit(NowPlayingMovieLoaded(
                  movies: (state as NowPlayingMovieLoaded).movies + movies,
                  hasReachedMax: false,
                ));
              }
            });
          }
        } catch (ex) {
          emit(
            NowPlayingMovieError(
              errorMessage: ex.toString(),
            ),
          );
        }
      }
    });
  }
}
