import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/data/models/series_response.dart';

import '../../helpers/json_reader.dart';

void main() {
  final tSeriesModel = SeriesModel(
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    firstAirDate: "2022-08-21",
    genreIds: [10765, 18, 10759],
    id: 94997,
    name: "House of the Dragon",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 5486.161,
    posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
    voteAverage: 8.6,
    voteCount: 1584,
  );

  final tSeriesResponseModel =
      SeriesResponse(seriesList: <SeriesModel>[tSeriesModel]);

  group("fromJson", () {
    test('Should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_series.json'));

      // act
      final result = SeriesResponse.fromJson(jsonMap);
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();

      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
            "first_air_date": "2022-08-21",
            "genre_ids": [10765, 18, 10759],
            "id": 94997,
            "name": "House of the Dragon",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "House of the Dragon",
            "overview":
                "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
            "popularity": 5486.161,
            "poster_path": "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
            "vote_average": 8.6,
            "vote_count": 1584,
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
