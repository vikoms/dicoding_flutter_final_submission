import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/series_detail.dart';
import '../repositories/series_repository.dart';

class SaveWatchlistSeries {
  final SeriesRepository repository;

  SaveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail series) {
    return repository.saveWatchlist(series);
  }
}
