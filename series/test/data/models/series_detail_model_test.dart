import 'package:flutter_test/flutter_test.dart';
import 'package:series/data/models/series_detail_model.dart';

void main() {
  final nextEpisode = NextEpisodeToAir(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final spokenLanguage = SpokenLanguage(
    englishName: 'englishName',
    iso6391: 'iso6391',
    name: 'name',
  );

  final createdBy = CreatedBy(
    id: 1,
    creditId: "creditId",
    name: 'name',
    gender: 1,
    profilePath: "profilePath",
  );

  final lastEpisodeToAir = LastEpisodeToAir(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );
  test('toJson should create correct JSON object for NextEpisodeToAir Model',
      () {
    final Map<String, dynamic> json = nextEpisode.toJson();

    expect(json["id"], 1);
    expect(json["runtime"], 1);
    expect(json["season_number"], 1);
    expect(json["show_id"], 1);
    expect(json["vote_average"], 1);
    expect(json["vote_count"], 1);
    expect(json["episode_number"], 1);
    expect(json["name"], 'name');
    expect(json["air_date"], 'airDate');
    expect(json["still_path"], 'stillPath');
    expect(json["production_code"], 'productionCode');
    expect(json["overview"], 'overview');
  });

  test('toJson should create correct JSON object for SpokenLanguage Model', () {
    final Map<String, dynamic> json = spokenLanguage.toJson();
    expect(json["english_name"], 'englishName');
    expect(json["iso_639_1"], 'iso6391');
    expect(json["name"], 'name');
  });
  test('toJson should create correct JSON object for CreatedBy Model', () {
    final Map<String, dynamic> json = createdBy.toJson();

    expect(json["name"], 'name');
    expect(json["profile_path"], 'profilePath');
    expect(json["gender"], 1);
    expect(json["id"], 1);
    expect(json["credit_id"], 'creditId');
  });
  test('toJson should create correct JSON object for LastEpisodeToAir Model',
      () {
    final Map<String, dynamic> json = lastEpisodeToAir.toJson();

    expect(json["id"], 1);
    expect(json["runtime"], 1);
    expect(json["season_number"], 1);
    expect(json["show_id"], 1);
    expect(json["vote_average"], 1);
    expect(json["vote_count"], 1);
    expect(json["episode_number"], 1);
    expect(json["name"], 'name');
    expect(json["air_date"], 'airDate');
    expect(json["still_path"], 'stillPath');
    expect(json["production_code"], 'productionCode');
    expect(json["overview"], 'overview');
  });
}
