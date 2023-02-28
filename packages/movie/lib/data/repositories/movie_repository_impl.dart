import 'dart:io';

import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/local/movie_local_data_source.dart';
import '../datasources/remote/movie_remote_data_source.dart';
import 'package:core/core.dart';

import '../model/movie_table.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies({
    int page = 1,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowPlayingMovies(page: page);
        if (page == 1) {
          localDataSource.cacheNowPlayingMovies(
              result.map((movie) => MovieTable.fromDTO(movie)).toList());
        }
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
        final result = await localDataSource.getCachedNowPlayingMovies();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getMovieRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularMovies(
          page: page,
        );
        if (page == 1) {
          localDataSource.cachePopularMovies(
              result.map((movie) => MovieTable.fromDTO(movie)).toList());
        }
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
        final result = await localDataSource.getCachedPopularMovies();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies({int page = 1}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedMovies(
          page: page,
        );
        if (page == 1) {
          localDataSource.cacaheTopRatedMovies(
              result.map((movie) => MovieTable.fromDTO(movie)).toList());
        }
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
        final result = await localDataSource.getCachedTopRatedMovies();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(
    String query,
    int page,
  ) async {
    try {
      final result = await remoteDataSource.searchMovies(query, page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    try {
      final result = await localDataSource
          .insertWatchlist(WatchlistTable.fromMovieEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
    try {
      final result = await localDataSource
          .removeWatchlist(WatchlistTable.fromMovieEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByGenre(
      int genreId, int page) async {
    try {
      final result = await remoteDataSource.getMoviesByGenre(genreId, page);
      return Right(result.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Genre>>> getMovieGenres() async {
    try {
      final result = await remoteDataSource.getMovieGenres();
      return Right(result.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
