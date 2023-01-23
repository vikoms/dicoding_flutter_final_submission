import 'package:core/data/db/database_helper.dart';
import 'package:core/utils/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:series/data/datasources/local/series_local_data_source.dart';
import 'package:series/data/datasources/remote/series_remote_data_source.dart';
import 'package:series/domain/repositories/series_repository.dart';

@GenerateMocks([
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
])
void main() {}
