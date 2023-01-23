import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';

import '../../dummy_data/dummy_data.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistLocalDataSource dataSource;
  late MockDatabaseHelper databaseHelper;
  setUp(() {
    databaseHelper = MockDatabaseHelper();
    dataSource = WatchlistLocalDataSourceImpl(
      databaseHelper: databaseHelper,
    );
  });

  const tId = 1;
  test(
      'should return success watchlist table when get watchlist by id successfully',
      () async {
    // arrange
    when(databaseHelper.getWatchListById(tId))
        .thenAnswer((_) async => testWatchListMovieMap);

    // act
    final result = await dataSource.getWatchListById(tId);

    // assert
    expect(result, testMovieWatchListTable);
  });
  test('should return null when data is not found', () async {
    // arrange
    when(databaseHelper.getWatchListById(tId)).thenAnswer((_) async => null);
    // act
    final result = await dataSource.getWatchListById(tId);
    // assert
    expect(result, null);
  });

  test('should return list of MovieTable from database', () async {
    // arrange
    when(databaseHelper.getWatchlist())
        .thenAnswer((_) async => [testWatchListMovieMap]);
    // act
    final result = await dataSource.getWatchlist();
    // assert
    expect(result, [testMovieWatchListTable]);
  });
}
