
// ignore_for_file: prefer_const_constructors

import 'package:event_finder/widgets/edit_event_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/events_model.dart';
import '../model/status_event.dart';
import '../view_model/event_view_model.dart';
import '../view_model/user_preferences.dart';
import 'package:event_finder/model/event_category.dart';


class EventCardOrganizer extends StatelessWidget {
  final bool isOrganizer;
  final Event event;
  final String userId;
  final VoidCallback? onEdit; // Memastikan properti 'event' ada

  // Constructor
  const EventCardOrganizer({super.key, required this.isOrganizer, required this.event, required this.userId, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title ?? 'No Title',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              event.description ?? 'No Description',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8),
            Text(
              event.date?.toIso8601String() ?? 'No Date',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            // Menampilkan tombol Edit dan Delete hanya jika status event adalah pending
            if (isOrganizer && event.status == StatusEvent.pending) ...[
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => EditEventDialog(
                          initialData: {
                            'title': event.title,
                            'date': event.date
                                ?.toIso8601String(), // Konversi DateTime ke ISO String
                            'time_start': event.time?.start
                                ?.toIso8601String(), // Ambil waktu mulai
                            'time_end': event.time?.end
                                ?.toIso8601String(), // Ambil waktu selesai
                            'location': event.location,
                            'description': event.description,
                            'category': event.category
                                ?.value, // Ambil nilai string dari enum menggunakan extension
                            'ticket_price': event.ticketPrice?.toString(),
                            'registration_link': event.registrationLink,
                            'event_id': event.id,
                          },
                        ),
                      ).then((_) {
                        if (onEdit != null) onEdit!(); // Trigger tindakan tambahan setelah edit
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: 
                    event.id == null
                        ? null // Disable button if ID is null
                        : () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Delete'),
                                  content: Text(
                                      'Are you sure you want to delete this event?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await Provider.of<EventViewModel>(
                                                  context,
                                                  listen: false)
                                              .deleteEventById(
                                            id: event.id!,
                                            organizerId:
                                                UserPreferences.userIdKey,
                                            context: context,
                                          );
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                      ),
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
