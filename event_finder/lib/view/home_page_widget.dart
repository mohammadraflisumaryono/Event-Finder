import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:event_finder/model/event_model.dart';
import 'package:event_finder/model/popular_model.dart';
import 'package:event_finder/shared/theme.dart';
import 'package:event_finder/widgets/event_card.dart';
import 'package:event_finder/widgets/popular_card.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Navbar widget
    Widget navbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Event Finder",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Wanna Find Some Event?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.register);
                },
                child: const Text(
                  'Signup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

    // Header widget
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find events near',
                    style: placeholderTextStyle,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Bandung, ID',
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('lib/res/assets/images/img_profile.png'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Search widget
    Widget search() {
      return Container(
        margin: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        height: 54,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/res/assets/images/ic_search.png'),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search all events...',
                  hintStyle: placeholderTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Upcoming events widget
    Widget upcomingEvents() {
      return Container(
        margin: const EdgeInsets.only(
          top: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Upcoming Events',
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // children: events
                  //     .map(
                  //       (item) => EventCard(item),
                  //     )
                  //     .toList(),
                ),
              ),
            )
          ],
        ),
      );
    }

    // Popular now widget
    Widget popularNow() {
      return Container(
        margin: const EdgeInsets.only(
          top: 24,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Now',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'See All',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children:
                        populars.map((item) => PopularCard(item)).toList()),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            navbar(),
            Expanded(
              child: ListView(
                children: [
                  header(),
                  search(),
                  upcomingEvents(),
                  popularNow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}