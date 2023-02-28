import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/bottom_loader.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

import '../bloc/bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  static const String ROUTE_NAME = "/search";
  final String type;

  SearchPage({
    required this.type,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc searchBloc;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    searchBloc = context.read<SearchBloc>();
    _scrollController.addListener(_onScroll);
    searchBloc.add(OnGetGenres(widget.type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff2B2937),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (query) {
                  if (query.isEmpty) {
                    searchBloc.add(OnGetGenres(widget.type));
                  } else {
                    if (widget.type == SEARCH_MOVIES) {
                      searchBloc.add(OnQueryChangeMovies(query));
                    } else {
                      searchBloc.add(OnQueryChangeSeries(query));
                    }
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Text(
            //   'Search Result',
            //   style: kHeading6,
            // ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case SearchLoading:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case GenreHasData:
                    final genres = (state as GenreHasData).result;
                    return Wrap(
                      spacing: 10,
                      children: genres.map((genre) {
                        return InkWell(
                          onTap: () {
                            if (widget.type == SEARCH_MOVIES) {
                              searchBloc.add(OnGetMoviesByGenre(
                                genre.id,
                              ));
                            } else {
                              searchBloc.add(OnGetSeriesByGenre(genre.id));
                            }
                          },
                          child: Chip(
                            label: Text(
                              genre.name,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  case SearchHasDataMovies:
                    final result = (state as SearchHasDataMovies).result;
                    return Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          if (index >= state.result.length) {
                            return const BottomLoader();
                          }
                          final movie = result[index];
                          return MovieCard(movie);
                        },
                        itemCount: state.hasReachedMax
                            ? state.result.length
                            : state.result.length + 1,
                      ),
                    );
                  case SearchHasDataSeries:
                    final result = (state as SearchHasDataSeries).result;

                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final series = result[index];
                          return SeriesCard(series);
                        },
                        itemCount: result.length,
                      ),
                    );
                  case SearchError:
                    return Expanded(
                      child: Center(
                        child: Text(
                          (state as SearchError).message,
                        ),
                      ),
                    );
                  default:
                    return Expanded(
                      child: Container(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      if (widget.type == SEARCH_MOVIES) {
        context.read<SearchBloc>().add(OnGetMoreMovies());
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
