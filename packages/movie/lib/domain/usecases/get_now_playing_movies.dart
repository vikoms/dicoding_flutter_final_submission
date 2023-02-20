import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute({
    int page = 1,
  }) {
    return repository.getNowPlayingMovies(
      page: page,
    );
  }
}
