import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/series.dart';
import '../repositories/series_repository.dart';

class GetPopularSeries {
  final SeriesRepository repository;

  GetPopularSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute({int page = 1}) {
    return repository.getPopularSeries(page: page);
  }
}
