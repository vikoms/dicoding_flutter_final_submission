import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/series.dart';
import '../repositories/series_repository.dart';

class GetNowPlayingSeries {
  final SeriesRepository repository;

  GetNowPlayingSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute({int page = 1}) {
    return repository.getNowPlayingSeries(page: page);
  }
}
