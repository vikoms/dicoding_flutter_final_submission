import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:trailer/data/datasource/trailer_remote_data_source.dart';
import 'package:trailer/domain/entities/video.dart';
import 'package:trailer/domain/repositories/trailer_repository.dart';

class TrailerRepositoryImpl implements TrailerRepository {
  final TrailerRemoteDataSource datasource;
  TrailerRepositoryImpl({required this.datasource});

  @override
  Future<Either<ServerFailure, List<Video>>> getVideo(
      String path, int id) async {
    try {
      final result = await datasource.getVideos(path, id);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure("Server Error"));
    }
  }
}
