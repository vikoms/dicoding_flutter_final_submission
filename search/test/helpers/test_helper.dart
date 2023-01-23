import 'package:mockito/annotations.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:series/domain/repositories/series_repository.dart';

@GenerateMocks([
  MovieRepository,
  SeriesRepository,
])
void main() {}
