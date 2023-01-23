import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

import '../../dummy_data/dummy_data.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistRepository watchlistRepository;
  late MockWatchlistLocalDataSource localDataSource;
  setUp(() {
    localDataSource = MockWatchlistLocalDataSource();
    watchlistRepository = WatchlistRepositoryImpl(
      localDataSource: localDataSource,
    );
  });

  final tWatchlistTable = <WatchlistTable>[testMovieWatchListTable];
  final tWatchlist = <Watchlist>[testMovieWatchList];
  const tId = 1;
  test('should return watchlist when get data is successfully', () async {
    // arrange
    when(localDataSource.getWatchlist())
        .thenAnswer((_) async => tWatchlistTable);

    // act
    final result = await watchlistRepository.getWatchlist();

    // assert
    final resultList = result.getOrElse(() => []);
    expect(resultList, tWatchlist);
  });

  test('should return watch status weather data is found', () async {
    // arrange
    when(localDataSource.getWatchListById(tId)).thenAnswer(
      (_) async => testMovieWatchListTable,
    );

    // act
    final result = await watchlistRepository.isAddedToWatchlist(tId);

    // assert
    expect(result, true);
  });
}
