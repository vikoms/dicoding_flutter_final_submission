import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/series.dart';
import '../pages/series_detail_page.dart';

class SeriesCard extends StatelessWidget {
  final Series series;
  final bool isSeriesRecommendations;
  const SeriesCard(this.series, [this.isSeriesRecommendations = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          if (!isSeriesRecommendations) {
            Navigator.pushNamed(
              context,
              SeriesDetailPage.ROUTE_NAME,
              arguments: series.id,
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              SeriesDetailPage.ROUTE_NAME,
              arguments: series.id,
            );
          }
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      series.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      series.overview ?? "-",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
