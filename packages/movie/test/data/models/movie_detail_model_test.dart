import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/model/movie_detail_model.dart';
import 'package:movie/domain/entities/movie_detail.dart';

void main() {
  final movie = MovieDetailResponse(
    adult: false,
    backdropPath: '/path/to/backdrop',
    budget: 1000000,
    genres: [
      GenreModel(id: 28, name: 'Action'),
      GenreModel(id: 12, name: 'Adventure')
    ],
    homepage: 'https://example.com',
    id: 123,
    imdbId: 'tt123456',
    originalLanguage: 'en',
    originalTitle: 'Example Movie',
    overview: 'This is an example movie.',
    popularity: 10.0,
    posterPath: '/path/to/poster',
    releaseDate: '2022-01-01',
    revenue: 2000000,
    runtime: 120,
    status: 'Released',
    tagline: 'An example movie.',
    title: 'Example Movie',
    video: false,
    voteAverage: 7.5,
    voteCount: 100,
  );

  test('toJson should create correct JSON object', () {
    final Map<String, dynamic> json = movie.toJson();

    expect(json["adult"], false);
    expect(json["backdrop_path"], '/path/to/backdrop');
    expect(json["budget"], 1000000);
    expect(json["genres"].length, 2);
    expect(json["genres"][0]["id"], 28);
    expect(json["genres"][0]["name"], 'Action');
    expect(json["genres"][1]["id"], 12);
    expect(json["genres"][1]["name"], 'Adventure');
    expect(json["homepage"], 'https://example.com');
    expect(json["id"], 123);
    expect(json["imdb_id"], 'tt123456');
    expect(json["original_language"], 'en');
    expect(json["original_title"], 'Example Movie');
    expect(json["overview"], 'This is an example movie.');
    expect(json["popularity"], 10.0);
    expect(json["poster_path"], '/path/to/poster');
    expect(json["release_date"], '2022-01-01');
    expect(json["revenue"], 2000000);
    expect(json["runtime"], 120);
    expect(json["status"], 'Released');
    expect(json["tagline"], 'An example movie.');
    expect(json["title"], 'Example Movie');
    expect(json["video"], false);
    expect(json["vote_average"], 7.5);
    expect(json["vote_count"], 100);
  });
}
