import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/series.dart';

class NowShowingCard extends StatelessWidget {
  const NowShowingCard({
    Key? key,
    required this.series,
    required this.index,
  }) : super(key: key);

  final Series series;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: index == 0
          ? const EdgeInsets.only(right: 10, left: 20)
          : const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              height: 215,
              imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            series.originalName ?? "",
            style: kSubtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          RatingBarIndicator(
            rating: (series.voteAverage ?? 0) / 2,
            itemCount: 5,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: kMikadoYellow,
            ),
            itemSize: 12,
          ),
        ],
      ),
    );
  }
}
