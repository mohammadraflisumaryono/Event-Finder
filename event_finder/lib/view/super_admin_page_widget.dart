import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../view_model/event_view_model.dart';

class SuperAdminEventWidget extends StatefulWidget {
  const SuperAdminEventWidget({super.key});

  @override
  _SuperAdminEventWidgetState createState() => _SuperAdminEventWidgetState();
}

class _SuperAdminEventWidgetState extends State<SuperAdminEventWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventViewModel>(context, listen: false).fetchEventByStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('SuperAdminEventWidget build');
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Manage Events', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Tambahkan aksi untuk menambahkan event baru
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Event List',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<EventViewModel>(
                builder: (context, eventViewModel, child) {
                  final response = eventViewModel.eventsList;
                  if (response.status == Status.LOADING) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (response.status == Status.ERROR) {
                    return Center(
                      child: Text('Error: ${response.message}'),
                    );
                  } else if (response.data?.events == null ||
                      response.data!.events!.isEmpty) {
                    return const Center(child: Text('No events available'));
                  }

                  final eventList = response.data!.events!;
                  return ListView.builder(
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      final event = eventList[index];
                      return EventCard(
                          event: event, eventViewModel: eventViewModel);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final dynamic event;
  final EventViewModel eventViewModel;

  const EventCard(
      {required this.event, required this.eventViewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title ?? 'No Title',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              event.description ?? 'No Description',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${event.status}',
              style: TextStyle(
                color: event.status == "Pending" ? Colors.orange : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (event.status == "Pending")
                  ElevatedButton.icon(
                    onPressed: () => eventViewModel.approveEvent(event.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Approve'),
                  ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => eventViewModel.rejectEvent(event.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
