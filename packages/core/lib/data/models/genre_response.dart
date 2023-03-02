import 'package:core/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';

class GenreResponse extends Equatable {
  final List<GenreModel> genres;

  GenreResponse({required this.genres});

  factory GenreResponse.fromJson(Map<String, dynamic> json) => GenreResponse(
        genres: List<GenreModel>.from(
            (json["genres"] as List).map((x) => GenreModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(genres.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [genres];
}
