import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/series_now_playing/now_playing_series_bloc.dart';
import '../bloc/series_popular/popular_series_bloc.dart';
import '../bloc/series_top_rated/top_rated_series_bloc.dart';
import '../route_arguments/series_list_arguments.dart';
import '../widgets/series_card_list.dart';

class SeriesListPage extends StatefulWidget {
  static const ROUTE_NAME = "/series-list";
  final SeriesListArguments arguments;
  const SeriesListPage({
    required this.arguments,
  });
  @override
  State<SeriesListPage> createState() => _SeriesListPageState();
}

class _SeriesListPageState extends State<SeriesListPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (widget.arguments.type == SeriesListEnum.NowPlaying) {
        context.read<NowPlayingSeriesBloc>().add(OnGetNowPlayingSeries());
      } else if (widget.arguments.type == SeriesListEnum.TopRated) {
        context.read<TopRatedSeriesBloc>().add(OnGetTopRatedSeries());
      } else if (widget.arguments.type == SeriesListEnum.Popular) {
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
        child: _buildContent(widget.arguments),
      ),
    );
  }

  Widget _buildContent(SeriesListArguments params) {
    if (params.type == MovieListEnum.NowPlaying) {
      return _buildNowPlayingSeries();
    } else if (params.type == MovieListEnum.Popular) {
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
            itemBuilder: (context, index) {
              final series = state.nowPlayingSeries[index];
              return SeriesCard(series);
            },
            itemCount: state.nowPlayingSeries.length,
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
            itemBuilder: (context, index) {
              final Series = state.popularSeries[index];
              return SeriesCard(Series);
            },
            itemCount: state.popularSeries.length,
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
}
