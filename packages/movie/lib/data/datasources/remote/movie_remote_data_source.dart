import 'dart:convert';

import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/genre_response.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:http/http.dart' as http;

import '../../model/movie_detail_model.dart';
import '../../model/movie_model.dart';
import '../../model/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies({
    int page = 1,
  });
  Future<List<MovieModel>> getPopularMovies({
    int page = 1,
  });
  Future<List<MovieModel>> getTopRatedMovies({
    int page = 1,
  });
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(
    String query,
    int page,
  );
  Future<List<MovieModel>> getMoviesByGenre(int genreId, int page);
  Future<List<GenreModel>> getMovieGenres();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies({
    int page = 1,
  }) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY&page=$page'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies({
    int page = 1,
  }) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/popular?$API_KEY&page=$page'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies({
    int page = 1,
  }) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY&page=$page'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(
    String query,
    int page,
  ) async {
    final response = await client.get(
        Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query&page=$page'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre(int genreId, int page) async {
    final response = await client.get(Uri.parse(
        '$BASE_URL/discover/movie?$API_KEY&sort_by=popularity.desc&page=$page&with_genres=$genreId'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GenreModel>> getMovieGenres() async {
    final response = await client
        .get(Uri.parse("$BASE_URL/genre/movie/list?$API_KEY&language=en"));
    if (response.statusCode == 200) {
      return GenreResponse.fromJson(json.decode(response.body)).genres;
    } else {
      throw ServerException();
    }
  }
}
