import 'package:core/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

final testWatchListMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'category': 'MOVIE',
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
