import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:trailer/domain/entities/video.dart';

abstract class TrailerRepository {
  Future<Either<ServerFailure, List<Video>>> getVideo(String path, int id);
}
