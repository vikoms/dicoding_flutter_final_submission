import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

@GenerateMocks([
  WatchlistLocalDataSource,
  DatabaseHelper,
  WatchlistRepository,
])
void main() {}
