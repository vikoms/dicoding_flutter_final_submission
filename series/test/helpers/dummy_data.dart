import 'package:core/domain/entities/genre.dart';
import 'package:series/data/models/series_table.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

final testSeriesWatchListTable = WatchlistTable(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
  category: WatchlistTable.SERIES,
);

final testWatchListSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'category': 'SERIES',
};

final testSeriesCache = SeriesTable(
  id: 130392,
  overview:
      'From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.',
  posterPath: '/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg',
  title: "The D'Amelio Show",
);

final testSeriesCacheMap = {
  'id': 130392,
  'overview':
      'From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.',
  'posterPath': '/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg',
  'title': "The D'Amelio Show",
};

final testSeriesFromCache = Series.Watchlist(
  id: 130392,
  overview:
      'From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.',
  posterPath: '/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg',
  originalName: "The D'Amelio Show",
);

final testSeriesDetail = SeriesDetail(
  adult: false,
  genres: [
    Genre(
      id: 1,
      name: "name",
    ),
  ],
  backdropPath: "backdropPath",
  originalName: "originalName",
  id: 1234,
  overview: "overview",
  posterPath: "posterPath",
  releaseDate: "releaseDate",
  voteAverage: 20.3,
  voteCount: 1250,
  seasons: [
    Season(
      airDate: "airDate",
      episodeCount: 20,
      id: 12,
      name: "name",
      overview: "overview",
      posterPath: "posterPath",
      seasonNumber: 12,
    ),
  ],
);

final testSeriesDetail2 = SeriesDetail(
  adult: false,
  genres: [
    Genre(
      id: 1,
      name: "name",
    ),
  ],
  backdropPath: "backdropPath",
  originalName: "title",
  id: 1,
  overview: "overview",
  posterPath: "posterPath",
  releaseDate: "releaseDate",
  voteAverage: 20.3,
  voteCount: 1250,
  seasons: [
    Season(
      airDate: "airDate",
      episodeCount: 20,
      id: 12,
      name: "name",
      overview: "overview",
      posterPath: "posterPath",
      seasonNumber: 12,
    ),
  ],
);

final testSeries = Series(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: [1, 2, 3],
  id: 1,
  name: 'name',
  originCountry: ['US'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 9.0,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
);
