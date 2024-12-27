import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (event.id != null) {
          Navigator.pushNamed(context, RoutesName.detailEvent,
              arguments: event.id);
        } else {
          print('Event ID is null!');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        constraints: const BoxConstraints(maxWidth: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: event.image != null
                      ? NetworkImage(event.image!)
                      : throw Exception('Image is required and cannot be null'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Judul
            Text(
              event.title ?? 'No Title',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Lokasi
            Text(
              event.location ?? 'Unknown Location',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            // Tanggal
            Text(
              event.date != null
                  ? DateFormat('dd MMM yyyy').format(event.date!)
                  : 'Unknown Date',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            // Harga
            Text(
              event.ticketPrice != null
                  ? 'Rp ${event.ticketPrice!.toStringAsFixed(2)}'
                  : 'Free',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
