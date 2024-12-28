import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard(
    this.event, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail event
        Navigator.pushNamed(context, RoutesName.detailEvent,
            arguments: event.id);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45, // Responsif width
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // White background for the card
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event image with dynamic size
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: event.image != null
                        ? NetworkImage(event.image!)
                        : throw Exception(
                            'Image is required and cannot be null'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Event title
              Text(
                event.title!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Event location
              Text(
                event.location!,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
              ),
              const SizedBox(height: 4),
              // Event date
              Text(
                DateFormat('MMM dd, yyyy')
                    .format(event.date ?? DateTime.now()), // Date formatting
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              // Event ticket price (if any)
              Text(
                event.ticketPrice != null
                    ? "Rp ${NumberFormat('#,###', 'id_ID').format(event.ticketPrice)}"
                    : 'Free', // Display 'Free' if no price
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
