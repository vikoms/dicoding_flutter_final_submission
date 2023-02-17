import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/watchlist.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<Watchlist>>> getWatchlist();

  Future<bool> isAddedToWatchlist(int id);
}
