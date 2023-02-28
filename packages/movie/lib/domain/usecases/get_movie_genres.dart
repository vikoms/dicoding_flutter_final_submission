import 'package:core/domain/entities/genre.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class GetMovieGenres {
  final MovieRepository repository;
  GetMovieGenres(this.repository);

  Future<Either<Failure, List<Genre>>> execute() async {
    return await repository.getMovieGenres();
  }
}
