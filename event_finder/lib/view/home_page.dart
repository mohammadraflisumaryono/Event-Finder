// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:event_finder/view_model/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:event_finder/model/event_category.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:event_finder/widgets/trending_event_carousel.dart';
import 'package:event_finder/widgets/event_card.dart';
import 'package:provider/provider.dart';
import 'package:event_finder/view/event_list_page.dart'; // Adjust the path according to your project structure

import '../data/response/status.dart';
import '../view_model/user_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventViewModel>(context, listen: false).fetchTrendingEvents();
      Provider.of<EventViewModel>(context, listen: false).getLatestEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Memberikan jarak agar lebih proporsional
          child: Image.asset(
            'lib/res/assets/images/logogoova.png',
            fit: BoxFit.contain),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Memberikan jarak horizontal
            child: ElevatedButton(
              onPressed: () async {
                // Cek apakah pengguna sudah login
                bool isLoggedIn = await UserPreferences.isLoggedIn();

                if (isLoggedIn) {
                  // Ambil role pengguna
                  String? role = await UserPreferences.getRole();

                  // Arahkan berdasarkan role
                  if (role == 'organizer') {
                    Navigator.pushNamed(context, RoutesName.adminHome);
                  } else if (role == 'admin') {
                    Navigator.pushNamed(context, RoutesName.superAdmin);
                  } else {
                    // Jika role tidak sesuai
                    Navigator.pushNamed(context, RoutesName.login);
                  }
                } else {
                  Navigator.pushNamed(context, RoutesName.login);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                elevation: 5,
              ),
              child: Text(
                'Create Event',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
                onSubmitted: (value) {
                  Provider.of<EventViewModel>(context, listen: false)
                      .fetchSearchAndCategory(query: value, category: null);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EventListPage(searchQuery: value, category: null),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: EventCategory.values
                      .asMap()
                      .entries
                      .map((entry) => _buildCategoryChip(
                            context,
                            entry.value.value, // Nama kategori
                            entry.key, // Indeks kategori
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 24),
              _buildSectionHeader(context, 'Trending Events'),
              SizedBox(height: 16),
              Consumer<EventViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.eventsList.status == Status.LOADING) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator
                  } else if (viewModel.eventsList.status == Status.COMPLETED) {
                    final events = viewModel.eventsList.data?.events ?? [];
                    return TrendingEventCarousel(events: events);
                  } else if (viewModel.eventsList.status == Status.ERROR) {
                    return Center(
                        child: Text('Error: ${viewModel.eventsList.message}'));
                  } else {
                    return Center(child: Text('No events found.'));
                  }
                },
              ),
              SizedBox(height: 24),
              // Menampilkan event terbaru menggunakan EventCard
              _buildSectionHeader(context, 'Latest Event'),
              SizedBox(height: 16),
              Consumer<EventViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.latestEvent.status == Status.LOADING) {
                    return Center(child: CircularProgressIndicator());
                  } else if (viewModel.latestEvent.status == Status.COMPLETED) {
                    final events = viewModel.latestEvent.data?.events;
                    if (events != null && events.isNotEmpty) {
                      // Ambil 6 event terbaru
                      final latestEvents = events.take(6).toList();
                      for (var event in latestEvents) {
                        // print('Event Details:');
                        event.toJson().forEach((key, value) {
                          // print('$key: $value');
                        });
                        print(
                            ''); // Tambahkan baris kosong untuk pemisah antar event
                      }
                      // Tampilkan daftar event
                      return LayoutBuilder(
  builder: (context, constraints) {
    // Hitung lebar card berdasarkan ukuran layar
    double width = constraints.maxWidth / 2 - 16; // 2 card per row, 16 jarak antar card
    double aspectRatio = width / 250; // Sesuaikan rasio aspek card

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 card per row
        crossAxisSpacing: 16, // Jarak horizontal antar card
        mainAxisSpacing: 16, // Jarak vertikal antar card
        childAspectRatio: aspectRatio, // Rasio aspek card agar proporsional
      ),
      physics: const NeverScrollableScrollPhysics(), // Disable scroll jika di dalam ScrollView
      shrinkWrap: true,
      itemCount: latestEvents.length,
      itemBuilder: (context, index) {
        final event = latestEvents[index];
        return EventCard(event); // Widget card
      },
    );
  },
);

                    } else {
                      return Center(child: Text('No latest events found.'));
                    }
                  } else if (viewModel.latestEvent.status == Status.ERROR) {
                    return Center(
                      child: Text('Error: ${viewModel.latestEvent.message}'),
                    );
                  } else {
                    return Center(child: Text('No latest events found.'));
                  }
                },
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
      BuildContext context, String categoryName, int index) {
    final colors = [
      Color(0xFFBDE0FE), // Pastel Blue
      Color(0xFFFFD6E0), // Pastel Pink
      Color.fromARGB(255, 244, 235, 184), // Pastel Yellow
      Color(0xFFC3FBD8), // Pastel Green
      Color(0xFFD5AAFF), // Pastel Purple
    ];

    final chipColor = colors[index % colors.length];

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          Provider.of<EventViewModel>(context, listen: false)
              .fetchSearchAndCategory(query: null, category: categoryName);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EventListPage(searchQuery: '', category: categoryName),
            ),
          );
        },
        child: Chip(
          label: Text(
            categoryName,
            style: TextStyle(
              color: Colors.black, // Warna teks tetap hitam
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: chipColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: chipColor, // Border sesuai warna chip
            ),
            borderRadius: BorderRadius.circular(12.0), // Bentuk rounded
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    //print(context);
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
        GestureDetector(
          onTap: () {
            Provider.of<EventViewModel>(context, listen: false)
              .fetchSearchAndCategory(query: null, category: null);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EventListPage(searchQuery: '', category: null),
                ),
              );
            },
            child: Text(
            'See all',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ]
      );
  }
}