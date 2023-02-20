import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/movie_list_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/route_arguments/movie_lis_arguments.dart';
import 'package:search/presentation/bloc/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:series/presentation/bloc/series_home/series_home_bloc.dart';
import 'package:series/presentation/bloc/series_now_playing/now_playing_series_bloc.dart';
import 'package:series/presentation/bloc/series_popular/popular_series_bloc.dart';
import 'package:series/presentation/bloc/series_top_rated/top_rated_series_bloc.dart';
import 'package:series/presentation/pages/home_series_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/series_list_page.dart';
import 'package:series/presentation/route_arguments/series_list_arguments.dart';
import 'package:trailer/presentation/bloc/trailer_bloc.dart';
import 'package:trailer/presentation/pages/trailer_page.dart';
import 'package:trailer/presentation/pages/youtube_page.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:watchlist/presentation/pages/watchlist_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingSeriesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<HomeMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SeriesHomeBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TrailerBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Moflix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Material(
          // child: CustomDrawer(
          //   content: HomePage(),
          // ),
          child: HomePage(),
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home-movie':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case '/home-series':
              return MaterialPageRoute(builder: (_) => HomeSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case MovieListPage.ROUTE_NAME:
              final arguments = settings.arguments as MovieListArguments;
              return CupertinoPageRoute(
                builder: (_) => MovieListPage(
                  params: arguments,
                ),
              );
            case SeriesListPage.ROUTE_NAME:
              final arguments = settings.arguments as SeriesListArguments;
              return CupertinoPageRoute(
                builder: (_) => SeriesListPage(
                  arguments: arguments,
                ),
              );
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                  builder: (_) => SeriesDetailPage(id: id));
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final arguments = settings.arguments as String;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(
                  type: arguments,
                ),
              );
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());

            case TrailerPage.ROUTE_NAME:
              final args = settings.arguments as TrailerArgs;
              return MaterialPageRoute(
                builder: (_) => TrailerPage(
                  args: args,
                ),
              );

            case YoutubePage.ROUTE_NAME:
              final videoId = settings.arguments as String;
              return MaterialPageRoute(
                  builder: (_) => YoutubePage(videoId: videoId));
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
