import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistStatus usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlistStatus(mockWatchlistRepository);
  });

  final tWatchlist = <Watchlist>[];
  final tId = 1;
  test('should get watchlist status of watchlist from repository', () async {
    when(mockWatchlistRepository.isAddedToWatchlist(tId))
        .thenAnswer((_) async => true);

    final result = await usecase.execute(tId);
    expect(result, true);
  });
}
