import 'package:equatable/equatable.dart';

import '../../domain/entities/series.dart';
import 'series_model.dart';

class SeriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  SeriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  factory SeriesTable.fromMap(Map<String, dynamic> map) => SeriesTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Series toEntity() => Series.Watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        originalName: title,
      );

  factory SeriesTable.fromDTO(SeriesModel series) => SeriesTable(
        id: series.id,
        title: series.originalName,
        posterPath: series.posterPath,
        overview: series.overview,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
