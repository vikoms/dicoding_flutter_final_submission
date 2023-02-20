import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/presentation/bloc/series_home/series_home_bloc.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/series_list_page.dart';
import 'package:series/presentation/route_arguments/series_list_arguments.dart';

import '../widgets/now_showing_card.dart';
import '../widgets/series_home_card.dart';

class HomeSeriesPage extends StatefulWidget {
  const HomeSeriesPage({super.key});

  @override
  State<HomeSeriesPage> createState() => _HomeSeriesPageState();
}

class _HomeSeriesPageState extends State<HomeSeriesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<SeriesHomeBloc>().add(OnGetNowPlayingSeriesHome());
      context.read<SeriesHomeBloc>().add(OnGetPopularSeriesHome());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderSection(
                title: 'TV Series',
                subTitle: "Entertainment Without Limits",
                searchArgType: SEARCH_SERIES,
              ),
              const SizedBox(
                height: 15,
              ),
              _buildNowPlayingSection(),
              _buildPopularSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNowPlayingSection() {
    return BlocBuilder<SeriesHomeBloc, SeriesHomeState>(
      builder: (context, state) {
        if (state.nowPlayingState == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.nowPlayingState == RequestState.Loaded) {
          return _buildNowShowingList(state);
        } else if (state.nowPlayingState == RequestState.Error) {
          return Center(
            child: Text(
              state.nowPlayingMessage,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
              'Oops.. something wrong, try again later',
              style: kSubtitle,
            ),
          );
        }
      },
    );
  }

  Widget _buildPopularSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular",
            style: kHeading6,
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<SeriesHomeBloc, SeriesHomeState>(
            builder: (context, state) {
              if (state.popularState == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.popularState == RequestState.Loaded) {
                return SizedBox(
                  height: state.popularSeries.length * 147,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index >= state.popularSeries.length) {
                        return const SeeMoreButton();
                      }

                      final series = state.popularSeries[index];
                      return SeriesHomeCard(series: series);
                    },
                    itemCount: state.popularSeries.length + 1,
                  ),
                );
              } else if (state.popularState == RequestState.Error) {
                return Center(
                  child: Text(
                    state.popularMessage,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
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
    );
  }

  Column _buildNowShowingList(SeriesHomeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            "Now Showing",
            style: kSubtitle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index >= state.nowPlayingSeries.length) {
                return Container(
                  width: 150,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    right: 20,
                    bottom: 80,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SeriesListPage.ROUTE_NAME,
                            arguments: SeriesListArguments(
                              "Now Playing",
                              SeriesListEnum.NowPlaying,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_right_alt,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'See More',
                        style: kSubtitle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }
              final series = state.nowPlayingSeries[index];
              return NowShowingCard(
                series: series,
                index: index,
              );
            },
            itemCount: state.nowPlayingSeries.length + 1,
          ),
        )
      ],
    );
  }
}

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          SeriesListPage.ROUTE_NAME,
          arguments: SeriesListArguments(
            "Popular",
            SeriesListEnum.Popular,
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade700.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'See More',
          style: kSubtitle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
