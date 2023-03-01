import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc.dart';

import 'package:core/core.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/widgets/carousel_movie_item.dart';
import 'package:movie/presentation/widgets/movie_card_home.dart';
import '../route_arguments/movie_lis_arguments.dart';
import 'movie_list_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  CarouselController carouselController = CarouselController();
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<HomeMovieBloc>().add(OnGetNowPlayingMovie());
      context.read<HomeMovieBloc>().add(OnGetPopularMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeaderSection(
                title: 'Movies',
                subTitle: "Explore the World of Film",
                searchArgType: SEARCH_MOVIES,
              ),
              _buildNowPlayingSection(),
              _buildPopularSection()
            ],
          ),
        ),
      ),
    );
  }

  Container _buildPopularSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular",
            style: kHeading6,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<HomeMovieBloc, HomeMovieState>(
            builder: (context, state) {
              if (state.popularState == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.popularState == RequestState.Loaded) {
                return SizedBox(
                  height: state.popularMovies.length * 147,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index >= state.popularMovies.length) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MovieListPage.ROUTE_NAME,
                              arguments: MovieListArguments(
                                  "Popular", MovieListEnum.Popular),
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
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          MovieDetailPage.ROUTE_NAME,
                          arguments: state.popularMovies[index].id,
                        ),
                        child: MovieCardHome(
                          movie: state.popularMovies[index],
                        ),
                      );
                    },
                    itemCount: state.popularMovies.length + 1,
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
                return const Center(
                  child: Text(
                    'Failed',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildNowPlayingSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 10,
          ),
          child: _buildSubHeading(
            title: 'Now Playing',
            onTap: () => Navigator.pushNamed(
              context,
              MovieListPage.ROUTE_NAME,
              arguments: MovieListArguments(
                "Now Playing",
                MovieListEnum.NowPlaying,
              ),
            ),
          ),
        ),
        BlocBuilder<HomeMovieBloc, HomeMovieState>(
          builder: (context, state) {
            if (state.nowPlayingState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.nowPlayingState == RequestState.Loaded) {
              return Container(
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                child: CarouselSlider(
                  carouselController: carouselController,
                  items: state.nowPlayingMovies
                      .map((movie) => CarouselMovieItem(movie: movie))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    height: 310,
                  ),
                ),
              );
            } else if (state.nowPlayingState == RequestState.Error) {
              return Center(
                child: Text(
                  state.nowPlayingMessage,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Failed',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
        ),
      ],
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('See More'),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
