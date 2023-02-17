import 'package:flutter_test/flutter_test.dart';
import 'package:series/domain/entities/series_detail.dart';

void main() {
  test('Season properties should be correctly initialized', () {
    final Season season = Season(
      airDate: '2022-01-01',
      episodeCount: 10,
      id: 123,
      name: 'Season 1',
      overview: 'This is the first season of the show.',
      posterPath: '/path/to/poster',
      seasonNumber: 1,
    );

    expect(season.airDate, '2022-01-01');
    expect(season.episodeCount, 10);
    expect(season.id, 123);
    expect(season.name, 'Season 1');
    expect(season.overview, 'This is the first season of the show.');
    expect(season.posterPath, '/path/to/poster');
    expect(season.seasonNumber, 1);
    expect(season.props, [
      season.airDate,
      season.episodeCount,
      season.id,
      season.name,
      season.overview,
      season.posterPath,
      season.seasonNumber,
    ]);
  });
}
