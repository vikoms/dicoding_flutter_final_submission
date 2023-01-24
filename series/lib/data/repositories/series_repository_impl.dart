import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import '../../domain/entities/series.dart';
import '../../domain/entities/series_detail.dart';
import '../../domain/repositories/series_repository.dart';
import '../datasources/local/series_local_data_source.dart';
import '../datasources/remote/series_remote_data_source.dart';
import '../models/series_table.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  final SeriesRemoteDataSource remoteDataSource;
  final SeriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Series>>> getNowPlayingSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowPlayingSeries();
        localDataSource.cacheNowPlayingSeries(
            result.map((series) => SeriesTable.fromDTO(series)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      } on TlsException {
        return Left(SSLFailure('Certificate Verification Failed'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedNowPlayingSeries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getPopularSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularSeries();
        localDataSource.cachePopularSeries(
            result.map((series) => SeriesTable.fromDTO(series)).toList());
        return Right(result.map((e) => e.toEntity()).toList());
      } on ServerException {
        return Left(
          ServerFailure(""),
        );
      } on SocketException {
        return Left(
          ConnectionFailure("Failed to connect to the network"),
        );
      } on TlsException {
        return Left(SSLFailure('Certificate Verification Failed'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedPopularSeries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, SeriesDetail>> getDetailSeries(int id) async {
    try {
      final result = await remoteDataSource.getDetailSeries(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(
        ServerFailure(""),
      );
    } on SocketException {
      return Left(
        ConnectionFailure("Failed to connect to the network"),
      );
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getTopRatedSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedSeries();
        localDataSource.cacheTopRatedSeries(
            result.map((series) => SeriesTable.fromDTO(series)).toList());
        return Right(result.map((data) => data.toEntity()).toList());
      } on ServerException {
        return Left(
          ServerFailure(""),
        );
      } on SocketException {
        return Left(ConnectionFailure("Failed to connect to the network"));
      } on TlsException {
        return Left(SSLFailure('Certificate Verification Failed'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedTopRatedSeries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(SeriesDetail series) async {
    try {
      final result = await localDataSource
          .removeWatchlist(WatchlistTable.fromSeriesEntity(series));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(SeriesDetail series) async {
    try {
      final result = await localDataSource
          .insertWatchlist(WatchlistTable.fromSeriesEntity(series));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<Series>>> searchSeries(String query) async {
    try {
      final result = await remoteDataSource.searchSeries(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(
        ConnectionFailure("Failed to connect to the network"),
      );
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getRecomendationSeries(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(""));
    } on SocketException {
      return Left(
        ConnectionFailure("Failed to connect to the network"),
      );
    }
  }
}
