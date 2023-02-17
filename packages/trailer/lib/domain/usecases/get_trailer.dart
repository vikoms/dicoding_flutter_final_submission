import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:trailer/domain/repositories/trailer_repository.dart';

import '../entities/video.dart';

class GetTrailer {
  final TrailerRepository repository;
  GetTrailer(this.repository);

  Future<Either<Failure, List<Video>>> execute(String path, int id) async {
    return await repository.getVideo(path, id);
  }
}
