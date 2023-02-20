import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

class SingleMovieListNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetPopularMovies getPopularMovies;

  SingleMovieListNotifier(
    this.getNowPlayingMovies,
    this.getTopRatedMovies,
    this.getPopularMovies,
  );

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovies(MovieListEnum type) async {
    switch (type) {
      case MovieListEnum.NowPlaying:
        await fetchNowPlayingMovies();
        break;
      case MovieListEnum.TopRated:
        await fetchTopRatedMovies();
        break;
      case MovieListEnum.Popular:
        await fetchPopularMovies();
        break;
      default:
        break;
    }
  }

  Future<void> fetchNowPlayingMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (moviesData) {
      _movies = moviesData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (moviesData) {
      _movies = moviesData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchPopularMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (moviesData) {
      _movies = moviesData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
