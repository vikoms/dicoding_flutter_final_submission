import 'dart:convert';

import 'package:core/core.dart';
import 'package:trailer/data/models/video_model.dart';
import 'package:http/http.dart' as http;

abstract class TrailerRemoteDataSource {
  Future<List<VideoModel>> getVideos(String path, int id);
}

class TrailerRemoteDataSourceImpl implements TrailerRemoteDataSource {
  final http.Client client;
  TrailerRemoteDataSourceImpl(this.client);

  @override
  Future<List<VideoModel>> getVideos(String path, int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/$path/$id/videos?$API_KEY'));

    if (response.statusCode == 200) {
      return VideoResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
