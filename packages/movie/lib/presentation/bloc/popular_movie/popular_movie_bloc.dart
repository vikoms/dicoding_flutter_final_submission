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
    int _page = 1;
    bool _hasNextPage = true;

    on<OnGetPopularMovies>((event, emit) async {
      final isConnected = await networkInfo.isConnected;
      if (_hasNextPage) {
        try {
          if (state is PopularMovieInitial) {
            emit(PopularMovieLoading());
            final movieInit = await getPopularMovies.execute();
            movieInit.fold((error) {
              emit(PopularMovieError(errorMessage: error.message));
            }, (movies) {
              emit(PopularMovieLoaded(
                movies: movies,
                hasReachedMax: false,
              ));
            });
          } else if (state is PopularMovieLoaded && isConnected) {
            _page++;
            final moreMovies = await getPopularMovies.execute(page: _page);
            moreMovies.fold((error) {
              emit(
                PopularMovieError(
                  errorMessage: error.message,
                ),
              );
            }, (movies) {
              if (movies.isEmpty) {
                _hasNextPage = false;
                emit((state as PopularMovieLoaded)
                    .copyWith(hasReachedMax: true));
              } else {
                emit(PopularMovieLoaded(
                  movies: (state as PopularMovieLoaded).movies + movies,
                  hasReachedMax: false,
                ));
              }
            });
          }
        } catch (ex) {
          emit(
            PopularMovieError(
              errorMessage: ex.toString(),
            ),
          );
        }
      }
    }, transformer: Utils.debounce(const Duration(milliseconds: 500)));
  }
}
