import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/series.dart';
import '../repositories/series_repository.dart';

class GetTopRatedSeries {
  final SeriesRepository repository;

  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getTopRatedSeries();
  }
}
