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
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
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
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index >= state.movies.length) {
                return const BottomLoader();
              }
              final movie = state.movies[index];
              return MovieCard(movie);
            },
            itemCount: state.hasReachedMax
                ? state.movies.length
                : state.movies.length + 1,
          );
        } else if (state is NowPlayingMoviesError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(
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
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index >= state.movies.length) {
                return const BottomLoader();
              }
              final movie = state.movies[index];
              return MovieCard(movie);
            },
            itemCount: state.hasReachedMax
                ? state.movies.length
                : state.movies.length + 1,
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

  void _onScroll() {
    if (_isBottom) {
      if (widget.params.type == MovieListEnum.NowPlaying) {
        context.read<NowPlayingMovieBloc>().add(OnGetMoreNowPlayingMovies());
      } else if (widget.params.type == MovieListEnum.Popular) {
        context.read<PopularMovieBloc>().add(OnGetMorePopularMovies());
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
