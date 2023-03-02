import 'package:core/domain/entities/genre.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies({int page = 1});
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1});
  Future<Either<Failure, List<Movie>>> getTopRatedMovies({int page = 1});
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> getMoviesByGenre(int genreId, int page);
  Future<Either<Failure, List<Movie>>> searchMovies(
    String query,
    int page,
  );
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<Either<Failure, List<Genre>>> getMovieGenres();
}
