import 'package:core/data/db/database_helper.dart';
import 'package:core/utils/network_info.dart';
import 'package:core/utils/http_client_ssl_pinning.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/data/datasources/local/movie_local_data_source.dart';
import 'package:movie/data/datasources/remote/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_genres.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_movies_by_genre.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:search/presentation/bloc/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:series/data/datasources/local/series_local_data_source.dart';
import 'package:series/data/datasources/remote/series_remote_data_source.dart';
import 'package:series/data/repositories/series_repository_impl.dart';
import 'package:series/domain/repositories/series_repository.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/domain/usecases/get_series_by_genre.dart';
import 'package:series/domain/usecases/get_series_genres.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';
import 'package:series/presentation/bloc/series_home/series_home_bloc.dart';
import 'package:series/presentation/bloc/series_now_playing/now_playing_series_bloc.dart';
import 'package:series/presentation/bloc/series_popular/popular_series_bloc.dart';
import 'package:series/presentation/bloc/series_top_rated/top_rated_series_bloc.dart';
import 'package:series/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:trailer/data/datasource/trailer_remote_data_source.dart';
import 'package:trailer/data/repositories/trailer_repository_impl.dart';
import 'package:trailer/domain/repositories/trailer_repository.dart';
import 'package:trailer/domain/usecases/get_trailer.dart';
import 'package:trailer/presentation/bloc/trailer_bloc.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  // locator.registerFactory(
  //   () => MovieListNotifier(
  //     getNowPlayingMovies: locator(),
  //     getPopularMovies: locator(),
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => MovieDetailNotifier(
  //     getMovieDetail: locator(),
  //     getMovieRecommendations: locator(),
  //     getWatchListStatus: locator(),
  //     saveWatchlist: locator(),
  //     removeWatchlist: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => SearchNotifier(
  //     searchMovies: locator(),
  //     searchSeries: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => PopularMoviesNotifier(
  //     locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => SingleMovieListNotifier(
  //     locator(),
  //     locator(),
  //     locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TopRatedMoviesNotifier(
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => SeriesDetailNotifier(
  //     getSeriesDetail: locator(),
  //     getWatchListStatus: locator(),
  //     removeWatchlist: locator(),
  //     saveWatchListSeries: locator(),
  //     getSeriesRecommendations: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => WatchlistMovieNotifier(
  //     getWatchlistMovies: locator(),
  //   ),
  // );

  // locator.registerFactory(
  //   () => SeriesListNotifier(
  //     getNowPlayingSeries: locator(),
  //     getPopularSeries: locator(),
  //     getTopRatedSeries: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => SingleSeriesListNotifier(
  //     getPopularSeries: locator(),
  //     getTopRatedSeries: locator(),
  //     getNowPlayingSeries: locator(),
  //   ),
  // );

// BLOC
  locator.registerFactory(
    () => SearchBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingMovieBloc(
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMovieBloc(
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularSeriesBloc(
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingSeriesBloc(
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => SeriesDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => HomeMovieBloc(
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => SeriesHomeBloc(
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => TrailerBloc(
      getTrailer: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetNowPlayingSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatus(locator()));
  locator.registerLazySingleton(() => GetTrailer(locator()));

  locator.registerLazySingleton(() => GetMoviesByGenre(locator()));
  locator.registerLazySingleton(() => GetMovieGenres(locator()));
  locator.registerLazySingleton(() => GetSeriesGenres(locator()));
  locator.registerLazySingleton(() => GetSeriesByGenre(locator()));
  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  locator.registerLazySingleton<SeriesRepository>(() => SeriesRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator(),
      ));

  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TrailerRepository>(
    () => TrailerRepositoryImpl(
      datasource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<WatchlistLocalDataSource>(
      () => WatchlistLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TrailerRemoteDataSource>(
      () => TrailerRemoteDataSourceImpl(locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
  locator.registerLazySingleton(() => DataConnectionChecker());
}
