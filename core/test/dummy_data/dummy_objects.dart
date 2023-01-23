import 'package:core/domain/entities/genre.dart';
import 'package:movie/data/model/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:series/data/models/series_table.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testSeries = Series(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: [1, 2, 3],
  id: 1,
  name: 'name',
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
);

// final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
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

final testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testSeriesCache = SeriesTable(
  id: 130392,
  overview:
      'From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.',
  posterPath: '/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg',
  title: "The D'Amelio Show",
);

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testSeriesFromCache = Series.Watchlist(
  id: 130392,
  overview:
      'From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.',
  posterPath: '/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg',
  originalName: "The D'Amelio Show",
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testSeriesCacheMap = {
  'id': 130392,
  'overview':
      'From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.',
  'posterPath': '/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg',
  'title': "The D'Amelio Show",
};

final testMovieWatchListTable = WatchlistTable(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
  category: WatchlistTable.MOVIE,
);

final testMovieWatchList = Watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
  category: WatchlistTable.MOVIE,
);
final testSeriesWatchList = Watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
  category: WatchlistTable.SERIES,
);

final testWatchlistTableMovieList = [testMovieWatchListTable];

final testSeriesWatchListTable = WatchlistTable(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
  category: WatchlistTable.SERIES,
);

final testWatchListMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'category': 'MOVIE',
};

final testWatchListSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'category': 'SERIES',
};

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
