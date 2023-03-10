import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute({int page = 1}) {
    return repository.getPopularMovies(
      page: page,
    );
  }
}
