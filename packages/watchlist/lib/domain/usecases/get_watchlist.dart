import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

import '../entities/watchlist.dart';

class GetWatchlist {
  final WatchlistRepository _repository;

  GetWatchlist(this._repository);

  Future<Either<Failure, List<Watchlist>>> execute() {
    return _repository.getWatchlist();
  }
}
