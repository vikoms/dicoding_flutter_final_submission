import 'package:core/core.dart';
import 'package:core/utils/state_enum.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/now_playing_movie/now_playing_movie_bloc.dart';
import '../bloc/popular_movie/popular_movie_bloc.dart';
import '../bloc/top_rated_movie/top_rated_movie_bloc.dart';
import '../providers/single_movie_list_notifier.dart';
import '../route_arguments/movie_lis_arguments.dart';
import '../widgets/movie_card_list.dart';

class MovieListPage extends StatefulWidget {
  static const ROUTE_NAME = '/movie-list';

  final MovieListArguments params;
  const MovieListPage({
    required this.params,
  });

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.params.type == MovieListEnum.NowPlaying) {
        context.read<NowPlayingMovieBloc>().add(OnGetNowPlayingMovies());
      } else if (widget.params.type == MovieListEnum.TopRated) {
        context.read<TopRatedMovieBloc>().add(OnGetTopRatedMovies());
      } else if (widget.params.type == MovieListEnum.Popular) {
        context.read<PopularMovieBloc>().add(OnGetPopularMovies());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.params.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: _buildContent(widget.params),
      ),
    );
  }

  Widget _buildContent(MovieListArguments params) {
    if (params.type == MovieListEnum.NowPlaying) {
      return _buildNowPlayingMovie();
    } else if (params.type == MovieListEnum.Popular) {
      return _buildPopularMovie();
    } else {
      return _buildTopRatedMovie();
    }
  }

  BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>
      _buildNowPlayingMovie() {
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
      builder: (context, state) {
        if (state is NowPlayingMoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NowPlayingMoviesLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MovieCard(movie);
            },
            itemCount: state.movies.length,
          );
        } else if (state is NowPlayingMoviesError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Center(
                child: Text(
              "Error",
              style: kHeading5,
            )),
          );
        }
      },
    );
  }

  BlocBuilder<PopularMovieBloc, PopularMovieState> _buildPopularMovie() {
    return BlocBuilder<PopularMovieBloc, PopularMovieState>(
      builder: (context, state) {
        if (state is PopularMovieLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularMovieLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MovieCard(movie);
            },
            itemCount: state.movies.length,
          );
        } else if (state is PopularMovieError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Center(
                child: Text(
              "Error",
              style: kHeading5,
            )),
          );
        }
      },
    );
  }

  BlocBuilder<TopRatedMovieBloc, TopRatedMovieState> _buildTopRatedMovie() {
    return BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
      builder: (context, state) {
        if (state is TopRatedMovieLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TopRatedMovieLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MovieCard(movie);
            },
            itemCount: state.movies.length,
          );
        } else if (state is TopRatedMovieError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Center(
                child: Text(
              "Error",
              style: kHeading5,
            )),
          );
        }
      },
    );
  }
}
