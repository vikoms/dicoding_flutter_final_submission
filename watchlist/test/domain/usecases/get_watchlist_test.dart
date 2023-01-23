import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlist(mockWatchlistRepository);
  });

  final tWatchlist = <Watchlist>[];

  test('should get list of watchlist from repository', () async {
    when(mockWatchlistRepository.getWatchlist())
        .thenAnswer((_) async => Right(tWatchlist));

    final result = await usecase.execute();
    expect(result, right(tWatchlist));
  });
}
