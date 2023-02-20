import 'package:flutter_test/flutter_test.dart';
import 'package:series/data/models/series_table.dart';

void main() {
  final series = SeriesTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  test('toJson should create correct JSON object', () {
    final Map<String, dynamic> json = series.toJson();

    expect(json["id"], 1);
    expect(json["title"], 'title');
    expect(json["posterPath"], 'posterPath');
    expect(json["overview"], 'overview');
  });
}
