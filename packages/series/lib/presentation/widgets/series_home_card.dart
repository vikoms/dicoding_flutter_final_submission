import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:series/presentation/pages/series_detail_page.dart';

import '../../domain/entities/series.dart';

class SeriesHomeCard extends StatelessWidget {
  const SeriesHomeCard({
    Key? key,
    required this.series,
  }) : super(key: key);

  final Series series;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          SeriesDetailPage.ROUTE_NAME,
          arguments: series.id,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 15,
        ),
        height: 130,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                width: 100,
                height: 130,
                imageUrl: '$BASE_IMAGE_URL_CAROUSEL${series.posterPath}',
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    series.originalName ?? "",
                    style: kSubtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    DateFormatter.formatFirstAirDate(
                      series.firstAirDate ?? "0000-00-00",
                    ),
                    style: kBodyText.copyWith(
                      color: kDavysGrey,
                    ),
                  ),
                  const Spacer(),
                  RatingBarIndicator(
                    rating: (series.voteAverage ?? 0) / 2,
                    itemCount: 5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: kMikadoYellow,
                    ),
                    itemSize: 24,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
