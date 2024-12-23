import 'package:flutter/material.dart';
import 'package:event_finder/view_model/super_admin_page_model.dart';

class PageSuperAdmin extends StatelessWidget {
  final List<Event> events = [
    Event(
      id: 1,
      title: 'Music Festival',
      description: 'A grand music festival in the city.',
      ticketPrice: 50.0,
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 3)),
      isApproved: false,
      createdBy: 'AdminUser1',
    ),
    Event(
      id: 2,
      title: 'Art Exhibition',
      description: 'A modern art exhibition.',
      ticketPrice: 20.0,
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      isApproved: false,
      createdBy: 'AdminUser2',
    ),
  ];

  void onApproveEvent(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Approve Event'),
        content: Text('Do you want to approve the event "${event.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Update event approval status
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Event "${event.title}" approved!')),
              );
            },
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }

  void onRejectEvent(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Event'),
        content: Text('Do you want to reject the event "${event.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Remove or mark event as rejected
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Event "${event.title}" rejected!')),
              );
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingEvents = events.where((event) => !event.isApproved).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin Event Management'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: pendingEvents.length,
        itemBuilder: (context, index) {
          final event = pendingEvents[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(event.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.description),
                  Text('Price: \$${event.ticketPrice.toStringAsFixed(2)}'),
                  Text('Created by: ${event.createdBy}'),
                  Text(
                    'Start: ${event.startTime.hour}:${event.startTime.minute}, '
                    'End: ${event.endTime.hour}:${event.endTime.minute}',
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () => onApproveEvent(context, event),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => onRejectEvent(context, event),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
