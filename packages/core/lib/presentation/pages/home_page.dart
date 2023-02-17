import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:series/presentation/pages/home_series_page.dart';
import 'package:watchlist/presentation/pages/watchlist_page.dart';

import '../../styles/colors.dart';
import '../../styles/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //create controller untuk tabBar
  late PageController controller;

  @override
  void initState() {
    controller = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const HomeMoviePage(),
      const HomeSeriesPage(),
      const WatchlistPage(),
    ];
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        blurOpacity: 0.2,
        color: kPrussianBlue,
        pageController: controller,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.movie_filter_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.movie_filter,
              color: kPrussianBlue,
            ),
            itemLabel: "Movie",
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.video_library,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.video_library,
              color: kPrussianBlue,
            ),
            itemLabel: "Series",
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.favorite_border_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.favorite,
              color: kPrussianBlue,
            ),
            itemLabel: "Favorite",
          )
        ],
        itemLabelStyle: kSubtitle.copyWith(
          fontSize: 12,
        ),
        notchColor: Colors.black87,
        onTap: (index) {
          controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}
