import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/series_detail.dart';
import '../repositories/series_repository.dart';

class GetSeriesDetail {
  final SeriesRepository repository;

  GetSeriesDetail(this.repository);

  Future<Either<Failure, SeriesDetail>> execute(int id) {
    return repository.getDetailSeries(id);
  }
}
