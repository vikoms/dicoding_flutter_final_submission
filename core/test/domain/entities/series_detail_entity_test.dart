import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tSeasons = [
    Season(
      airDate: "airDate",
      episodeCount: 1,
      id: 1,
      name: "name",
      overview: "overview",
      posterPath: "posterPath",
      seasonNumber: 2,
    ),
  ];

  group('SeriesDetail', () {
    test(
        'should have adult, backdropPath, genres, id, originalName, overview, posterPath, releaseDate, voteAverage, and voteCount properties',
        () {
      final seriesDetail = SeriesDetail(
        adult: true,
        backdropPath: 'backdrop.jpg',
        genres: [Genre(id: 1, name: 'Action')],
        id: 123,
        originalName: 'Original Name',
        overview: 'Overview',
        posterPath: 'poster.jpg',
        releaseDate: '2020-01-01',
        voteAverage: 7.5,
        voteCount: 100,
        seasons: tSeasons,
      );

      expect(seriesDetail.adult, true);
      expect(seriesDetail.backdropPath, 'backdrop.jpg');
      expect(seriesDetail.genres, [Genre(id: 1, name: 'Action')]);
      expect(seriesDetail.id, 123);
      expect(seriesDetail.originalName, 'Original Name');
      expect(seriesDetail.overview, 'Overview');
      expect(seriesDetail.posterPath, 'poster.jpg');
      expect(seriesDetail.releaseDate, '2020-01-01');
      expect(seriesDetail.voteAverage, 7.5);
      expect(seriesDetail.voteCount, 100);
      expect(seriesDetail.seasons, tSeasons);
    });
  });

  group('Season', () {
    test(
        'should have airDate, episodeCount, id, name, overview, posterPath, and seasonNumber properties',
        () {
      final season = Season(
        airDate: "airDate",
        episodeCount: 20,
        id: 12,
        name: "name",
        overview: "overview",
        posterPath: "posterPath",
        seasonNumber: 12,
      );

      expect(season.airDate, 'airDate');
      expect(season.episodeCount, 20);
      expect(season.id, 12);
      expect(season.name, 'name');
      expect(season.overview, 'overview');
      expect(season.posterPath, 'posterPath');
      expect(season.seasonNumber, 12);
      expect(<Season>[season], testSeriesDetail.seasons);
    });
  });
}
