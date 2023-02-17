import 'package:flutter_test/flutter_test.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/domain/entities/series.dart';

void main() {
  final tSeriesModel = SeriesModel(
    backdropPath: "backdropPath",
    firstAirDate: "20-10-2020",
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: "Name",
    originCountry: ["originCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: "/path.jpg",
    voteAverage: 2.5,
    voteCount: 124,
  );

  final tSeries = Series(
      backdropPath: "backdropPath",
      firstAirDate: "20-10-2020",
      genreIds: [1, 2, 3, 4],
      id: 1,
      name: "Name",
      originCountry: ["originCountry"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "/path.jpg",
      voteAverage: 2.5,
      voteCount: 124);

  test('should be a subclass of SeriesEntity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
