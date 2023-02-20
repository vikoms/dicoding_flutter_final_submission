import 'package:core/data/db/database_helper.dart';

import '../models/watchlist_table.dart';

abstract class WatchlistLocalDataSource {
  Future<WatchlistTable?> getWatchListById(int id);
  Future<List<WatchlistTable>> getWatchlist();
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});
  @override
  Future<WatchlistTable?> getWatchListById(int id) async {
    final result = await databaseHelper.getWatchListById(id);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlist() async {
    final result = await databaseHelper.getWatchlist();
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }
}
