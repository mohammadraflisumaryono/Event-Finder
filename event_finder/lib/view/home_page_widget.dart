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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        actions: [
          Icon(Icons.notifications_outlined, color: Colors.black),
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
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                'Trending Events',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search event...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.filter_list),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: EventCategory.values
                      .map((category) => _buildCategoryChip(category.value))  // Menampilkan chip untuk setiap kategori
                      .toList(),
                ),
              ),
              SizedBox(height: 24),
              _buildSectionHeader('Newest Events'),  // Ganti judul jadi 'Newest Events'
              SizedBox(height: 16),
              
              // Menampilkan event terbaru
              for (var event in events) ...[
                _buildTrendingEventCard(
                  title: event.title,
                  location: event.location,
                  date: DateFormat('MMM dd, yyyy').format(event.date), // Format tanggal
                  price: event.price,
                  image: event.image,
                ),
                SizedBox(height: 24),
              ],

              // Bagian Events Near You (tetap sama)
              _buildSectionHeader('Events Near You'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildEventCard(
                    title: 'Muse : Will of the People',
                    location: 'Jakarta, Indonesia',
                    date: 'July 23 2023',
                    price: 'IDR 500.000',
                    image: 'assets/muse.jpg',
                  ),
                  _buildEventCard(
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

   Widget _buildCategoryChip(String categoryName) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(categoryName),  // Menampilkan nama kategori dalam chip
        backgroundColor: Colors.grey.shade200,  // Warna latar belakang chip
      ),
    );
  }
}

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'See all',
          style: TextStyle(color: Colors.purple),
        ),
      ],
    );
  }

  Widget _buildTrendingEventCard({
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start from $price',
                    style: TextStyle(
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

  Widget _buildEventCard({
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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      location,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
