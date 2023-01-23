import 'package:core/data/db/database_helper.dart';
import 'package:core/utils/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/data/datasources/local/movie_local_data_source.dart';
import 'package:movie/data/datasources/remote/movie_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:series/data/datasources/local/series_local_data_source.dart';
import 'package:series/data/datasources/remote/series_remote_data_source.dart';
import 'package:series/domain/repositories/series_repository.dart';

@GenerateMocks([
  MovieRepository,
  SeriesRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
])
void main() {}
