import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series_detail.dart';

import '../../domain/entities/watchlist.dart';
import 'package:movie/domain/entities/movie_detail.dart';

class WatchlistTable extends Equatable {
  static const String MOVIE = "MOVIE";
  static const String SERIES = "SERIES";
  int? id;
  String? overview;
  String? posterPath;
  String? title;
  String? category;

  WatchlistTable({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.category,
  });

  factory WatchlistTable.fromMovieEntity(MovieDetail movie) => WatchlistTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        category: WatchlistTable.MOVIE,
      );

  factory WatchlistTable.fromSeriesEntity(SeriesDetail series) =>
      WatchlistTable(
        id: series.id,
        overview: series.overview,
        posterPath: series.posterPath,
        title: series.originalName,
        category: WatchlistTable.SERIES,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'category': category,
      };

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        category: map['category'],
      );

  Watchlist toEntity() => Watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
        category: category,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, overview, posterPath, title, category];
}
