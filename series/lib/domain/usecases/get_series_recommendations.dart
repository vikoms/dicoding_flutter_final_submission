import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/series.dart';
import '../repositories/series_repository.dart';

class GetSeriesRecommendations {
  final SeriesRepository repository;

  GetSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Series>>> execute(int id) {
    return repository.getSeriesRecommendations(id);
  }
}
