import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trailer/presentation/bloc/trailer_bloc.dart';
import 'package:trailer/presentation/pages/youtube_page.dart';

class TrailerPage extends StatefulWidget {
  static const String ROUTE_NAME = "/trailer";
  final TrailerArgs args;

  const TrailerPage({
    super.key,
    required this.args,
  });

  @override
  State<TrailerPage> createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TrailerBloc>().add(OnGetTrailer(
            path: widget.args.path,
            id: widget.args.id,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trailer'),
      ),
      body: Container(
        child: BlocBuilder<TrailerBloc, TrailerState>(
          builder: (context, state) {
            if (state is TrailerLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Text(
                      "Loading...",
                      style: kSubtitle,
                    ),
                  ],
                ),
              );
            } else if (state is TrailerLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final video = state.videos[index];
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 10),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          height: 200,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CachedNetworkImage(
                                  imageUrl: ThumbnailHelper.getThumbnailUrl(
                                      video.key),
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        YoutubePage.ROUTE_NAME,
                                        arguments: video.key,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.play_circle,
                                      size: 80,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            top: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                video.name,
                                style: kHeading6,
                              ),
                              Text(
                                video.type,
                                style: kBodyText.copyWith(
                                  color: kDavysGrey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: state.videos.length,
              );
            } else if (state is TrailerError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: kSubtitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TrailerBloc>().add(
                              OnGetTrailer(
                                  path: widget.args.path, id: widget.args.id),
                            );
                      },
                      child: const Text(
                        "Try Again",
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Oopss... Something wrong, please try again later",
                  style: kSubtitle.copyWith(
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
