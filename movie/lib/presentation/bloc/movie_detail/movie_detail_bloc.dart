import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

import '../../../../domain/usecases/get_movie_detail.dart';
import '../../../../domain/usecases/get_movie_recommendations.dart';
import '../../../../domain/usecases/save_watchlist_movie.dart';
import '../../../domain/usecases/remove_watchlist_movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchListAddSuccessMessage = "Added to Watchlist";
  static const watchListRemoveSuccessMessage = "Removed from Watchlist";
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchlistStatus getWatchListStatus;
  final SaveMovieWatchlist saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;
  MovieDetailBloc(
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.getWatchListStatus,
    this.removeWatchlist,
    this.saveWatchlist,
  ) : super(MovieDetailState()) {
    on<OnGetDetailMovie>((event, emit) async {
      final movieId = event.movieId;

      emit(state.copyWith(movieState: RequestState.Loading));

      final result = await getMovieDetail.execute(movieId);
      final recommendationResult =
          await getMovieRecommendations.execute(movieId);
      final status = await getWatchListStatus.execute(movieId);

      result.fold(
        (failure) {
          emit(state.copyWith(
            movieState: RequestState.Error,
            message: failure.message,
          ));
        },
        (movie) {
          recommendationResult.fold(
            (failure) {
              emit(state.copyWith(
                movieState: RequestState.Error,
                message: failure.message,
              ));
            },
            (movies) async {
              emit(
                state.copyWith(
                  movieDetail: movie,
                  movieRecommendations: movies,
                  movieState: RequestState.Loaded,
                  isAddedToWatchlist: status,
                ),
              );
            },
          );
        },
      );
    });

    on<OnAddWatchlistMovie>((event, emit) async {
      final movie = event.movie;
      final result = await saveWatchlist.execute(movie);

      result.fold(
        (failure) async {
          emit(
            state.copyWith(watchlistMessage: failure.message),
          );
        },
        (successMessage) {
          emit(state.copyWith(
            watchlistMessage: successMessage,
            isAddedToWatchlist: true,
          ));
        },
      );
    });

    on<OnRemoveWatchlistMovie>((event, emit) async {
      final movie = event.movie;
      final result = await removeWatchlist.execute(movie);

      result.fold(
        (failure) async {
          emit(
            state.copyWith(watchlistMessage: failure.message),
          );
        },
        (successMessage) {
          emit(state.copyWith(
            watchlistMessage: successMessage,
          ));
          add(OnGetWatchlistStatus(movie.id));
        },
      );
    });

    on<OnGetWatchlistStatus>(
      ((event, emit) async {
        final status = await getWatchListStatus.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: status));
      }),
    );
  }
}
