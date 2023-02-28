import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetSeriesByGenre {
  final SeriesRepository repository;
  GetSeriesByGenre(this.repository);
  Future<Either<Failure, List<Series>>> execute(int genreId, int page) async {
    return await repository.getSeriesByGenre(genreId, page);
  }
}
