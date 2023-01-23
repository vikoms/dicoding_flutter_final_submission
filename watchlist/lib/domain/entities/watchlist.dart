import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {
  static const String MOVIE = "MOVIE";
  static const String SERIES = "SERIES";
  int? id;
  String? overview;
  String? posterPath;
  String? title;
  String? category;

  Watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.category,
  });

  @override
  List<Object?> get props => [id, overview, posterPath, title, category];
}
