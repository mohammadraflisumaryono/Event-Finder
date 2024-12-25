// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:event_finder/view/create_account_page_widget.dart';
import 'package:event_finder/view/login_page_widget.dart';
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
  final BoxFit fit;
  final String placeholder;

  Event({
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    required this.image,
    this.fit = BoxFit.cover,
    this.placeholder = 'assets/placeholder.jpg',
  });
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late List<Event> events;

  @override
  void initState() {
    super.initState();
    // Daftar event yang ada
    events = [
      Event(
        title: 'Coldplay: Music of the Spheres',
        location: 'Gelora Bung Karno Stadium',
        date: DateTime(2023, 11, 15),
        price: 'IDR 1.100.000',
        image:
            'https://i.pinimg.com/736x/6a/9a/9b/6a9a9b246937dd614475b439f5da81d4.jpg',
      ),
      Event(
        title: 'Muse: Will of the People',
        location: 'Jakarta, Indonesia',
        date: DateTime(2023, 7, 23),
        price: 'IDR 500.000',
        image:
            'https://farm8.staticflickr.com/7878/47302195272_aa4ecd4016_h.jpg',
      ),
      Event(
        title: 'One Direction: Where We Are',
        location: 'Jakarta, Indonesia',
        date: DateTime(2023, 10, 29),
        price: 'IDR 800.000',
        image:
            'https://i.guim.co.uk/img/static/sys-images/Guardian/Pix/pictures/2014/10/12/1413103103754/acfe846d-18b9-4029-bb0b-acea080c47d1-620x372.jpeg?width=445&dpr=1&s=none&crop=none',
      ),
    ];

    // Urutkan berdasarkan tanggal terbaru
    events.sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Image.asset(
          'lib/res/assets/images/logo.png',
          width: 40,
          height: 40,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAccountPageWidget()),
              );
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPageWidget()),
              );
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                  prefixIcon: Icon(Icons.search,
                      color: Theme.of(context).iconTheme.color),
                  suffixIcon: Icon(Icons.filter_list,
                      color: Theme.of(context).iconTheme.color),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
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
                      .map((category) =>
                          _buildCategoryChip(context, category.value))
                      .toList(),
                ),
              ),
              SizedBox(height: 24),
              _buildSectionHeader(context, 'Newest Events'),
              SizedBox(height: 16),

              // Menampilkan event terbaru
              for (var event in events) ...[
                _buildEventCard(
                  context, events,
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
                    context, events,
                    title: 'Muse : Will of the People',
                    location: 'Jakarta, Indonesia',
                    date: 'July 23 2023',
                    price: 'IDR 500.000',
                    image:
                        'https://farm8.staticflickr.com/7878/47302195272_aa4ecd4016_h.jpg',
                  ),
                  _buildEventCard(
                    context, events,
                    title: 'One Direction : Where We Are',
                    location: 'Jakarta, Indonesia',
                    date: 'Oct 29 2023',
                    price: 'IDR 800.000',
                    image:
                        'https://i.guim.co.uk/img/static/sys-images/Guardian/Pix/pictures/2014/10/12/1413103103754/acfe846d-18b9-4029-bb0b-acea080c47d1-620x372.jpeg?width=445&dpr=1&s=none&crop=none',
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
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'See all',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, List<Event> events, {
    required String title,
    required String location,
    required String date,
    required String price,
    required String image,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 2, blurRadius: 4),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(image, fit: BoxFit.cover, width: double.infinity, height: 100),
            SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 4),
            Text(location, style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: 4),
            Text(date, style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: 8),
            Text(price, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}