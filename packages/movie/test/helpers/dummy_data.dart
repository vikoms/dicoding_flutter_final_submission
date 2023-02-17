import 'package:core/domain/entities/genre.dart';
import 'package:movie/data/model/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

final testMovieWatchListTable = WatchlistTable(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
  category: WatchlistTable.MOVIE,
);

final testWatchListMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'category': 'MOVIE',
};

final testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
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

final testMovie = Movie(
  adult: false,
  backdropPath: '/path/to/backdrop.jpg',
  genreIds: [1, 2, 3],
  id: 123,
  originalTitle: 'Original Title',
  overview: 'This is a movie about something.',
  popularity: 10.0,
  posterPath: '/path/to/poster.jpg',
  releaseDate: '2022-01-01',
  title: 'Movie Title',
  video: false,
  voteAverage: 8.0,
  voteCount: 1000,
);
