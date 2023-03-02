import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetSeriesGenres {
  final SeriesRepository repository;
  GetSeriesGenres(this.repository);
  Future<Either<Failure, List<Genre>>> execute() async {
    return await repository.getSeriesGenres();
  }
}
