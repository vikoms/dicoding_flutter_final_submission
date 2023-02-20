import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/series_now_playing/now_playing_series_bloc.dart';
import '../bloc/series_popular/popular_series_bloc.dart';
import '../bloc/series_top_rated/top_rated_series_bloc.dart';
import '../route_arguments/series_list_arguments.dart';
import '../widgets/bottom_loader.dart';
import '../widgets/series_card_list.dart';

class SeriesListPage extends StatefulWidget {
  static const ROUTE_NAME = "/series-list";
  final SeriesListArguments arguments;
  const SeriesListPage({
    super.key,
    required this.arguments,
  });
  @override
  State<SeriesListPage> createState() => _SeriesListPageState();
}

class _SeriesListPageState extends State<SeriesListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      final listType = widget.arguments.type;
      if (listType == SeriesListEnum.NowPlaying) {
        context.read<NowPlayingSeriesBloc>().add(OnGetNowPlayingSeries());
      } else if (listType == SeriesListEnum.TopRated) {
        context.read<TopRatedSeriesBloc>().add(OnGetTopRatedSeries());
      } else if (listType == SeriesListEnum.Popular) {
        context.read<PopularSeriesBloc>().add(OnGetPopularSeries());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final listType = widget.arguments.type;
    if (listType == SeriesListEnum.NowPlaying) {
      return _buildNowPlayingSeries();
    } else if (listType == SeriesListEnum.Popular) {
      return _buildPopularSeries();
    } else {
      return _buildTopRatedSeries();
    }
  }

  BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>
      _buildNowPlayingSeries() {
    return BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
      builder: (context, state) {
        if (state is NowPlayingSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NowPlayingSeriesLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index >= state.series.length) {
                return const BottomLoader();
              }
              final series = state.series[index];
              return SeriesCard(series);
            },
            itemCount: state.hasReachedMax
                ? state.series.length
                : state.series.length + 1,
          );
        } else if (state is NowPlayingSeriesError) {
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
              ),
            ),
          );
        }
      },
    );
  }

  BlocBuilder<PopularSeriesBloc, PopularSeriesState> _buildPopularSeries() {
    return BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
      builder: (context, state) {
        if (state is PopularSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularSeriesLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index >= state.series.length) {
                return const BottomLoader();
              }
              final series = state.series[index];
              return SeriesCard(series);
            },
            itemCount: state.hasReachedMax
                ? state.series.length
                : state.series.length + 1,
          );
        } else if (state is PopularSeriesError) {
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
              ),
            ),
          );
        }
      },
    );
  }

  BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState> _buildTopRatedSeries() {
    return BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
      builder: (context, state) {
        if (state is TopRatedSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TopRatedSeriesLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final Series = state.topRatedSeries[index];
              return SeriesCard(Series);
            },
            itemCount: state.topRatedSeries.length,
          );
        } else if (state is TopRatedSeriesError) {
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
              ),
            ),
          );
        }
      },
    );
  }

  void _onScroll() {
    if (_isBottom) {
      if (widget.arguments.type == SeriesListEnum.NowPlaying) {
        context.read<NowPlayingSeriesBloc>().add(OnGetNowPlayingSeries());
      } else if (widget.arguments.type == SeriesListEnum.Popular) {
        context.read<PopularSeriesBloc>().add(OnGetPopularSeries());
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
