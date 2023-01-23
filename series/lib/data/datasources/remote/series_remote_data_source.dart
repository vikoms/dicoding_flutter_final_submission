import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;

import '../../models/series_detail_model.dart';
import '../../models/series_model.dart';
import '../../models/series_response.dart';

abstract class SeriesRemoteDataSource {
  Future<List<SeriesModel>> getNowPlayingSeries();
  Future<List<SeriesModel>> getPopularSeries();
  Future<SeriesDetailResponse> getDetailSeries(int id);
  Future<List<SeriesModel>> getTopRatedSeries();
  Future<List<SeriesModel>> searchSeries(String query);
  Future<List<SeriesModel>> getRecomendationSeries(int id);
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  final http.Client client;

  SeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SeriesModel>> getNowPlayingSeries() async {
    final response =
        await client.get(Uri.parse("$BASE_URL/tv/on_the_air?$API_KEY"));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularSeries() async {
    final response =
        await client.get(Uri.parse("$BASE_URL/tv/popular?$API_KEY"));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeriesDetailResponse> getDetailSeries(int id) async {
    final response = await client.get(Uri.parse("$BASE_URL/tv/$id?$API_KEY"));
    if (response.statusCode == 200) {
      return SeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    final response =
        await client.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY"));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getRecomendationSeries(int id) async {
    final response = await client
        .get(Uri.parse("$BASE_URL/tv/$id/recommendations?$API_KEY"));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }
}
