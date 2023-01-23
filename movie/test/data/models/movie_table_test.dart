import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/model/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';

void main() {
  final movie = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  test('toJson should create correct JSON object', () {
    final Map<String, dynamic> json = movie.toJson();

    expect(json["id"], 1);
    expect(json["title"], 'title');
    expect(json["posterPath"], 'posterPath');
    expect(json["overview"], 'overview');
  });
}
