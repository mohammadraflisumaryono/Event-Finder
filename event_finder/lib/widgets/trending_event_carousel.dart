// ignore_for_file: library_private_types_in_public_api

import 'package:event_finder/model/events_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widget TrendingEventCarousel
class TrendingEventCarousel extends StatefulWidget {
  final List<Event> events; // Trending events dari HomePage

  const TrendingEventCarousel({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  _TrendingEventCarouselState createState() => _TrendingEventCarouselState();
}

class _TrendingEventCarouselState extends State<TrendingEventCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 3), () {
      if (_pageController.hasClients && widget.events.isNotEmpty) {
        _currentPage = (_currentPage + 1) % widget.events.length;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          final event = widget.events[index];
          return TrendingEventCard(
            title: event.title ?? "No Title",
            location: event.location ?? "No Location",
            date:
                DateFormat('MMM dd, yyyy').format(event.date ?? DateTime.now()),
            price: event.ticketPrice != null
                ? "Rp ${event.ticketPrice!.toStringAsFixed(0)}"
                : "Free", // Menggunakan format harga
            image: event.image ??
                "https://via.placeholder.com/150", // Fallback jika tidak ada gambar
          );
        },
      ),
    );
  }
}

// Widget TrendingEventCard
class TrendingEventCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String price;
  final String image;

  const TrendingEventCard({
    Key? key,
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      location,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      date,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      price,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
