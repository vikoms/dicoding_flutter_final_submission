import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/series_detail/series_detail_bloc.dart';
import '../providers/series_detail_notifier.dart';
import '../widgets/series_detail_content.dart';

class SeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-series';
  final int id;
  SeriesDetailPage({required this.id});

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<SeriesDetailBloc>(context)
          .add(OnGetSeriesDetail(widget.id));
      BlocProvider.of<SeriesDetailBloc>(context)
          .add(OnGetWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SeriesDetailBloc, SeriesDetailState>(
      listenWhen: (previous, current) {
        return previous.watchlistMessage != current.watchlistMessage &&
            current.watchlistMessage != '';
      },
      listener: (context, state) {
        final message = state.watchlistMessage;
        if (message == SeriesDetailBloc.watchListAddSuccessMessage ||
            message == SeriesDetailBloc.watchListRemoveSuccessMessage) {
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
        body: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
          builder: (context, state) {
            if (state.seriesState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.seriesState == RequestState.Loaded) {
              final series = state.series;
              return SafeArea(
                child: SeriesDetailContent(
                  series!,
                  state.isAddedWatchlist,
                  state.recommendationSeries,
                ),
              );
            } else {
              return Text(state.message);
            }
          },
        ),
      ),
    );
  }
}
