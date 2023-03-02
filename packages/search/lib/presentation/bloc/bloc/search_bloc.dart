import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_genres.dart';
import 'package:movie/domain/usecases/get_movies_by_genre.dart';
import 'package:series/domain/usecases/get_series_by_genre.dart';
import 'package:series/domain/usecases/get_series_genres.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_series.dart';
import 'package:series/domain/entities/series.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SearchSeries _searchSeries;
  final GetMovieGenres _getMovieGenres;
  final GetMoviesByGenre _getMoviesByGenre;
  final GetSeriesByGenre _getSeriesByGenre;
  final GetSeriesGenres _getSeriesGenre;
  final NetworkInfo _networkInfo;

  SearchBloc(
    this._searchMovies,
    this._searchSeries,
    this._getMovieGenres,
    this._getMoviesByGenre,
    this._getSeriesByGenre,
    this._getSeriesGenre,
    this._networkInfo,
  ) : super(SearchEmpty()) {
    int _page = 1;
    bool _hasNextPage = true;
    on<OnGetGenres>((event, emit) async {
      _page = 1;
      _hasNextPage = true;
      emit(SearchLoading());
      Either<Failure, List<Genre>> result;
      if (event.genreType == SEARCH_MOVIES) {
        result = await _getMovieGenres.execute();
      } else {
        result = await _getSeriesGenre.execute();
      }
      result.fold((l) {
        emit(SearchEmpty());
      }, (genres) {
        emit(GenreHasData(genres));
      });
    });

    on<OnQueryChangeMovies>((event, emit) async {
      final query = event.query;

      _page = 1;
      _hasNextPage = true;
      emit(SearchLoading());
      final result = await _searchMovies.execute(query, _page);

      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (data) {
        emit(SearchHasDataMovies(
          result: data,
          query: event.query,
        ));
      });
    }, transformer: Utils.debounce(const Duration(milliseconds: 500)));

    on<OnQueryChangeSeries>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchSeries.execute(query, _page);
      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (data) {
        emit(SearchHasDataSeries(
          result: data,
        ));
      });
    }, transformer: Utils.debounce(const Duration(milliseconds: 500)));

    on<OnGetMoviesByGenre>((event, emit) async {
      final moviesFiltered = await _getMoviesByGenre.execute(event.genreId, 1);
      moviesFiltered.fold((error) {
        emit(SearchError(error.message));
      }, (movies) {
        if (movies.isEmpty) {
          _hasNextPage = false;
          emit((state as SearchHasDataMovies).copyWith(
            hasReachedMax: true,
          ));
        } else {
          _page++;
          emit(SearchHasDataMovies(
            result: movies,
            selectedGenreId: event.genreId,
          ));
        }
      });
    });

    on<OnGetSeriesByGenre>((event, emit) async {
      final seriesFiltered = await _getSeriesByGenre.execute(event.genreId, 1);
      seriesFiltered.fold((error) {
        emit(SearchError(error.message));
      }, (series) {
        if (series.isEmpty) {
          _hasNextPage = false;
          emit((state as SearchHasDataSeries).copyWith(
            hasReachedMax: true,
          ));
        } else {
          _page++;
          emit(SearchHasDataSeries(
            result: series,
            selectedGenreId: event.genreId,
          ));
        }
      });
    });

    on<OnGetMoreMovies>((event, emit) async {
      bool isConnected = await _networkInfo.isConnected;
      if (!_hasNextPage && !isConnected) {
        return;
      }

      final query = (state as SearchHasDataMovies).query;
      final selectedGenreId = (state as SearchHasDataMovies).selectedGenreId;
      Either<Failure, List<Movie>> result;
      if (query.isEmpty) {
        result = await _getMoviesByGenre.execute(selectedGenreId!, _page);
      } else {
        result = await _searchMovies.execute(query, _page);
      }

      result.fold((l) {}, (movies) {
        if (movies.isEmpty) {
          _hasNextPage = false;
          emit((state as SearchHasDataMovies).copyWith(
            hasReachedMax: true,
          ));
        } else {
          _page++;
          emit(
            SearchHasDataMovies(
              result: (state as SearchHasDataMovies).result + movies,
              hasReachedMax: false,
              selectedGenreId: selectedGenreId,
              query: query,
            ),
          );
        }
      });
    }, transformer: Utils.debounce(const Duration(milliseconds: 500)));

    on<OnGetMoreSeries>((event, emit) async {
      bool isConnected = await _networkInfo.isConnected;
      if (!_hasNextPage && !isConnected) {
        return;
      }

      final query = (state as SearchHasDataSeries).query;
      final selectedGenreId = (state as SearchHasDataSeries).selectedGenreId;
      Either<Failure, List<Series>> result;
      if (query.isEmpty) {
        result = await _getSeriesByGenre.execute(selectedGenreId!, _page);
      } else {
        result = await _searchSeries.execute(query, _page);
      }

      result.fold((l) {}, (series) {
        if (series.isEmpty) {
          _hasNextPage = false;
          emit((state as SearchHasDataSeries).copyWith(
            hasReachedMax: true,
          ));
        } else {
          _page++;
          emit(
            SearchHasDataSeries(
              result: (state as SearchHasDataSeries).result + series,
              hasReachedMax: false,
              selectedGenreId: selectedGenreId,
              query: query,
            ),
          );
        }
      });
    }, transformer: Utils.debounce(const Duration(milliseconds: 500)));
  }
}
