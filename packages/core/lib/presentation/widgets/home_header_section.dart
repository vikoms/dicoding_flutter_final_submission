import 'package:flutter/material.dart';

import '../../core.dart';

class HomeHeaderSection extends StatelessWidget {
  final String title;
  final String subTitle;
  final String searchArgType;
  const HomeHeaderSection({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.searchArgType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 35,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kHeading5,
              ),
              Text(
                subTitle,
                style: kBodyText.copyWith(
                  color: kDavysGrey,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                SEARCH_ROUTE,
                arguments: searchArgType,
              );
            },
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                top: 12,
                left: 25,
                right: 12,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF282A3E).withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
                size: 32,
              ),
            ),
          )
        ],
      ),
    );
  }
}
