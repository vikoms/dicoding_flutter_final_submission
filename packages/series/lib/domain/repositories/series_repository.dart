import 'package:core/domain/entities/genre.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/series.dart';
import '../entities/series_detail.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Series>>> getNowPlayingSeries({int page = 1});
  Future<Either<Failure, List<Series>>> getPopularSeries({int page = 1});
  Future<Either<Failure, List<Series>>> getTopRatedSeries();
  Future<Either<Failure, SeriesDetail>> getDetailSeries(int id);
  Future<Either<Failure, List<Series>>> searchSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(SeriesDetail series);
  Future<Either<Failure, String>> removeWatchlist(SeriesDetail series);
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id);
  Future<Either<Failure, List<Series>>> getSeriesByGenre(int genreId, int page);
  Future<Either<Failure, List<Genre>>> getSeriesGenres();
}
