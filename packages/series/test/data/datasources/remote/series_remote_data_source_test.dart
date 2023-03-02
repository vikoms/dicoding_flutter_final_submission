import 'dart:convert';

import 'package:core/data/models/genre_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:series/data/datasources/remote/series_remote_data_source.dart';
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/data/models/series_response.dart';

import '../../../helpers/test_http_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=b807fc0668b99af6a06ea5e34423da26';
  const BASE_URL = 'https://api.themoviedb.org/3';
  final _page = 1;

  late SeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing_series.json')))
        .seriesList;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse("$BASE_URL/tv/on_the_air?$API_KEY&page=$_page")))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/now_playing_series.json'), 200));
      // act
      final result = await dataSource.getNowPlayingSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse("$BASE_URL/tv/on_the_air?$API_KEY&page=$_page")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_series.json')))
        .seriesList;

    test('should return list of series when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse("$BASE_URL/tv/popular?$API_KEY&page=$_page")))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_series.json'), 200));
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, tSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse("$BASE_URL/tv/popular?$API_KEY&page=$_page")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_series.json')))
        .seriesList;

    test('should return list of series when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY")))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_series.json'), 200));
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, tSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series detail', () {
    final tId = 1;
    final tSeriesDetail = SeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/series_detail.json')));

    test('should return series detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/$tId?$API_KEY")))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/series_detail.json'), 200));
      // act
      final result = await dataSource.getDetailSeries(tId);
      // assert
      expect(result, equals(tSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/$tId?$API_KEY")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getDetailSeries(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series recommendations', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series_recommendations.json')))
        .seriesList;
    final tId = 1;

    test('should return list of series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse("$BASE_URL/tv/$tId/recommendations?$API_KEY")))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series_recommendations.json'), 200));
      // act
      final result = await dataSource.getRecomendationSeries(tId);
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse("$BASE_URL/tv/$tId/recommendations?$API_KEY")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getRecomendationSeries(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search series', () {
    final tSearchResult = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_shooter_series.json')))
        .seriesList;
    final tQuery = 'Shooter';

    test('should return list of series when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '$BASE_URL/search/tv?$API_KEY&query=$tQuery&page=$_page')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_shooter_series.json'), 200));
      // act
      final result = await dataSource.searchSeries(
        query: tQuery,
        page: _page,
      );
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '$BASE_URL/search/tv?$API_KEY&query=$tQuery&page=$_page')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(query: tQuery, page: _page);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Genre Movie', () {
    final tGenreResult = GenreResponse.fromJson(
            json.decode(readJson('dummy_data/series_genre.json')))
        .genres;

    test('should return list of genre when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse("$BASE_URL/genre/tv/list?$API_KEY&language=en")))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/series_genre.json'), 200));
      // act
      final result = await dataSource.getSeriesGenres();
      // assert
      expect(result, tGenreResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse("$BASE_URL/genre/tv/list?$API_KEY&language=en")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesGenres();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Movies By Genre', () {
    final tMovieResult = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing_series.json')))
        .seriesList;
    final tGenreId = 1;

    test('should return list of movies when response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(
              '$BASE_URL/discover/tv?$API_KEY&sort_by=popularity.desc&page=$_page&with_genres=$tGenreId')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/now_playing_series.json'), 200));

      // act
      final result = await dataSource.getSeriesByGenre(
        genreId: tGenreId,
        page: _page,
      );
      expect(result, tMovieResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(
              '$BASE_URL/discover/tv?$API_KEY&sort_by=popularity.desc&page=$_page&with_genres=$tGenreId')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final call = dataSource.getSeriesByGenre(genreId: tGenreId, page: _page);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
