import 'package:flutter/material.dart';
import 'package:event_finder/view_model/event_view_model.dart';
import 'package:event_finder/widgets/event_card.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';

class EventListPage extends StatelessWidget {
  final String? category;
  final String searchQuery;

  const EventListPage({Key? key, this.category, required this.searchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category != null ? '$category Events' : 'Search Results',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Consumer<EventViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.eventsList.status == Status.LOADING) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.eventsList.status == Status.COMPLETED) {
            final events = viewModel.eventsList.data?.events ?? [];
            if (events.isEmpty) {
              return const Center(child: Text('No events found.'));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dua kartu per baris
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75, // Sesuaikan rasio kartu
                ),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return EventCard(event); // Menggunakan widget EventCard
                },
              ),
            );
          } else if (viewModel.eventsList.status == Status.ERROR) {
            return Center(
              child: Text('Error: ${viewModel.eventsList.message}'),
            );
          } else {
            return const Center(child: Text('No events found.'));
          }
        },
      ),
    );
  }
}
