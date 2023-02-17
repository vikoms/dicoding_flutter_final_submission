import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_detail/movie_detail_bloc.dart';
import '../widgets/movie_detail_content.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-movie';

  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      BlocProvider.of<MovieDetailBloc>(context)
          .add(OnGetDetailMovie(widget.id));
      BlocProvider.of<MovieDetailBloc>(context)
          .add(OnGetWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieDetailBloc, MovieDetailState>(
      listenWhen: (previous, current) =>
          previous.watchlistMessage != current.watchlistMessage &&
          current.watchlistMessage != '',
      listener: (context, state) {
        final message = state.watchlistMessage;
        if (message == MovieDetailBloc.watchListAddSuccessMessage ||
            message == MovieDetailBloc.watchListRemoveSuccessMessage) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(message),
                );
              });
        }
      },
      child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state.movieState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.movieState == RequestState.Loaded) {
              return SafeArea(
                child: DetailContent(
                  state.movieDetail!,
                  state.movieRecommendations,
                  state.isAddedToWatchlist,
                ),
              );
            } else if (state.movieState == RequestState.Error) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "Terdapat kesalahan",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: 150,
          height: 40,
          child: FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed(
              TRAILER_ROUTE,
              arguments: TrailerArgs(
                path: 'movie',
                id: widget.id,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: kMikadoYellow,
            elevation: 5.0,
            child: Container(
              child: Row(
                children: [
                  const Icon(
                    Icons.play_arrow,
                    size: 40,
                    color: kPrussianBlue,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Watch Trailer",
                    style: kBodyText.copyWith(
                      color: kPrussianBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
