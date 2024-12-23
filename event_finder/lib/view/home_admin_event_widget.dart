import 'package:flutter/material.dart';
import 'package:event_finder/view_model/home_admin_event_model.dart';

class HomeAdminEventPage extends StatelessWidget {
  final bool isAdmin;
  final List<Event> events = [
    Event(
      id: 1,
      title: 'Music Festival',
      description: 'A grand music festival in the city.',
      ticketPrice: 50.0,
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 3)),
      isApproved: true,
      createdBy: 'GuestUser1',
    ),
    Event(
      id: 2,
      title: 'Art Exhibition',
      description: 'A modern art exhibition.',
      ticketPrice: 20.0,
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      isApproved: false,
      createdBy: 'GuestUser2',
    ),
  ];

  HomeAdminEventPage({super.key, required this.isAdmin});

  void onCreateEvent(BuildContext context) {
    Navigator.pushNamed(context, '/createEvent');
  }

  void onEditEvent(BuildContext context, Event event) {
    if (isAdmin || (!event.isApproved && event.createdBy == 'GuestUser1')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditEventPage(event: event)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You cannot edit this event')),
      );
    }
  }

  void onDeleteEvent(BuildContext context, int eventId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Add deletion logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Event deleted successfully!')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredEvents = isAdmin
        ? events // Admin sees all events
        : events.where((event) => event.createdBy == 'GuestUser1').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Event Management'),
        backgroundColor: Colors.blueGrey,
        actions: [
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onCreateEvent(context),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          final event = filteredEvents[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(event.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.description),
                  Text('Price: \$${event.ticketPrice.toStringAsFixed(2)}'),
                  Text(
                    'Status: ${event.isApproved ? 'Approved' : 'Pending'}',
                    style: TextStyle(
                      color: event.isApproved ? Colors.green : Colors.orange,
                    ),
                  ),
                  Text(
                      'Start: ${event.startTime.hour}:${event.startTime.minute}'),
                  Text('End: ${event.endTime.hour}:${event.endTime.minute}'),
                  Text('Created by: ${event.createdBy}'),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    onEditEvent(context, event);
                  } else if (value == 'delete') {
                    onDeleteEvent(context, event.id);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  if (isAdmin)
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () => onCreateEvent(context),
              backgroundColor: Colors.blueGrey,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class EditEventPage extends StatelessWidget {
  final Event event;

  const EditEventPage({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Event: ${event.title}'),
        backgroundColor: Colors.blueGrey,
      ),
      body: const Center(
        child: Text('Form to edit the event'),
      ),
    );
  }
}
