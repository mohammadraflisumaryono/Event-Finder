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
        leading: Image.asset(
          'lib/res/assets/images/logogoova.png',
          width: 40,
          height: 40,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.login);
            },
            child: Text(
              'Create Event',
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
                      .map((category) =>
                          _buildCategoryChip(context, category.value))
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
                      print('Latest events: $latestEvents');

                      // Tampilkan daftar event
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: latestEvents.length,
                        itemBuilder: (context, index) {
                          final event = latestEvents[index];
                          return EventCard(
                              event); // Gantikan dengan widget yang sesuai untuk menampilkan event
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

  Widget _buildCategoryChip(BuildContext context, String categoryName) {
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
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          backgroundColor: Theme.of(context).chipTheme.backgroundColor,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    print(context);
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
}
