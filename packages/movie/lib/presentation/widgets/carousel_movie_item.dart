import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/movie.dart';
import '../pages/movie_detail_page.dart';

class CarouselMovieItem extends StatelessWidget {
  final Movie movie;
  const CarouselMovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        MovieDetailPage.ROUTE_NAME,
        arguments: movie.id,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              imageUrl: '$BASE_IMAGE_URL_CAROUSEL${movie.backdropPath}',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      movie.title ?? "",
                      style: kSubtitle,
                    ),
                    Text(
                      DateFormatter.formatDate(movie.releaseDate ?? ""),
                      style: kBodyText.copyWith(
                        color: kDavysGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: RatingBarIndicator(
                    rating: (movie.voteAverage ?? 0) / 2,
                    itemCount: 5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: kMikadoYellow,
                    ),
                    itemSize: 12,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
