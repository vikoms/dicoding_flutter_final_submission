import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

import '../entities/movie.dart';

class GetMoviesByGenre {
  final MovieRepository repository;
  GetMoviesByGenre(this.repository);
  Future<Either<Failure, List<Movie>>> execute(int genreId, int page) async {
    return await repository.getMoviesByGenre(genreId, page);
  }
}
