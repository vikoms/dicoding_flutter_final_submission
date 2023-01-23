import 'package:core/core.dart';
import 'package:core/presentation/widgets/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/pages/series_list_page.dart';

import '../bloc/series_now_playing/now_playing_series_bloc.dart';
import '../bloc/series_popular/popular_series_bloc.dart';
import '../bloc/series_top_rated/top_rated_series_bloc.dart';
import '../route_arguments/series_list_arguments.dart';

class HomeSeriesPage extends StatefulWidget {
  @override
  State<HomeSeriesPage> createState() => _HomeSeriesPageState();
}

class _HomeSeriesPageState extends State<HomeSeriesPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //   () => Provider.of<SeriesListNotifier>(context, listen: false)
    //     ..fetchNowPlayingSeries()
    //     ..fetchPopularSeries()
    //     ..fetchTopRatedSeries(),
    // );

    Future.microtask(() {
      context.read<NowPlayingSeriesBloc>().add(OnGetNowPlayingSeries());
      context.read<PopularSeriesBloc>().add(OnGetPopularSeries());
      context.read<TopRatedSeriesBloc>().add(OnGetTopRatedSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: "Now Playing",
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    SeriesListPage.ROUTE_NAME,
                    arguments: SeriesListArguments(
                      "Now Playing",
                      SeriesListEnum.NowPlaying,
                    ),
                  ),
                },
              ),
              // Consumer<SeriesListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.nowPlayingState;
              //     if (state == RequestState.Loading) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return ItemList(data.nowPlayingSeries, false);
              //     } else {
              //       return Text('Failed');
              //     }
              //   },
              // ),

              BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
                builder: (context, state) {
                  if (state is NowPlayingSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingSeriesLoaded) {
                    return ItemList(state.nowPlayingSeries, false);
                  } else {
                    return Center(
                      child: Text(
                        'Oops.. something wrong, try again later',
                        style: kSubtitle,
                      ),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: "Popular",
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    SeriesListPage.ROUTE_NAME,
                    arguments: SeriesListArguments(
                      "Popular",
                      SeriesListEnum.Popular,
                    ),
                  ),
                },
              ),
              // Consumer<SeriesListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.popularState;
              //     if (state == RequestState.Loading) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return ItemList(data.popularSeries, false);
              //     } else {
              //       return Text('Failed');
              //     }
              //   },
              // ),

              BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
                builder: (context, state) {
                  if (state is PopularSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularSeriesLoaded) {
                    return ItemList(state.popularSeries, false);
                  } else {
                    return Center(
                      child: Text(
                        'Oops.. something wrong, try again later',
                        style: kSubtitle,
                      ),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: "Top Rated",
                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    SeriesListPage.ROUTE_NAME,
                    arguments: SeriesListArguments(
                        "Top Rated", SeriesListEnum.TopRated),
                  ),
                },
              ),
              // Consumer<SeriesListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.topRatedState;
              //     if (state == RequestState.Loading) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return ItemList(data.topRatedSeries, false);
              //     } else {
              //       return Text('Failed');
              //     }
              //   },
              // ),

              BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedSeriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedSeriesLoaded) {
                    return ItemList(state.topRatedSeries, false);
                  } else {
                    return Center(
                      child: Text(
                        'Oops.. something wrong, try again later',
                        style: kSubtitle,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
