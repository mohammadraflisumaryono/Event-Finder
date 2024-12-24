// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl untuk format tanggal
import 'package:event_finder/model/event_category.dart';

// Model Event
class Event {
  final String title;
  final String location;
  final DateTime date;
  final String price;
  final String image;

  Event({
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    required this.image,
  });
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar event yang ada
    List<Event> events = [
      Event(
        title: 'Coldplay: Music of the Spheres',
        location: 'Gelora Bung Karno Stadium',
        date: DateTime(2023, 11, 15),
        price: 'IDR 1.100.000',
        image: 'assets/coldplay.jpg',
      ),
      Event(
        title: 'Muse: Will of the People',
        location: 'Jakarta, Indonesia',
        date: DateTime(2023, 7, 23),
        price: 'IDR 500.000',
        image: 'assets/muse.jpg',
      ),
      Event(
        title: 'One Direction: Where We Are',
        location: 'Jakarta, Indonesia',
        date: DateTime(2023, 10, 29),
        price: 'IDR 800.000',
        image: 'assets/one_direction.jpg',
      ),
    ];

    // Urutkan berdasarkan tanggal terbaru
    events.sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
        actions: [
          Icon(Icons.notifications_outlined, color: Theme.of(context).iconTheme.color),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian untuk search bar dan kategori
              Text(
                'Find',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Trending Events',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search event...',
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                  suffixIcon: Icon(Icons.filter_list, color: Theme.of(context).iconTheme.color),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: EventCategory.values
                      .map((category) => _buildCategoryChip(context, category.value))
                      .toList(),
                ),
              ),
              SizedBox(height: 24),
              _buildSectionHeader(context, 'Newest Events'),
              SizedBox(height: 16),

              // Menampilkan event terbaru
              for (var event in events) ...[
                _buildTrendingEventCard(
                  context,
                  title: event.title,
                  location: event.location,
                  date: DateFormat('MMM dd, yyyy').format(event.date),
                  price: event.price,
                  image: event.image,
                ),
                SizedBox(height: 24),
              ],

              // Bagian Events Near You (tetap sama)
              _buildSectionHeader(context, 'Events Near You'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildEventCard(
                    context,
                    title: 'Muse : Will of the People',
                    location: 'Jakarta, Indonesia',
                    date: 'July 23 2023',
                    price: 'IDR 500.000',
                    image: 'assets/muse.jpg',
                  ),
                  _buildEventCard(
                    context,
                    title: 'One Direction : Where We Are',
                    location: 'Jakarta, Indonesia',
                    date: 'Oct 29 2023',
                    price: 'IDR 800.000',
                    image: 'assets/one_direction.jpg',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String categoryName) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(
          categoryName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: Theme.of(context).chipTheme.backgroundColor,
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'See all',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  Widget _buildTrendingEventCard(
    BuildContext context, {
    required String title,
    required String location,
    required String date,
    required String price,
    required String image,
  }) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(image),
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    location,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start from $price',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required String location,
    required String date,
    required String price,
    required String image,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      location,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      price,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
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
