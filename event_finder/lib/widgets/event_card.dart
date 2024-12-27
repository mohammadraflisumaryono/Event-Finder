import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

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
        Navigator.pushNamed(context, RoutesName.detailEvent, arguments: event);
      },
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.45, // Sesuaikan lebar agar responsif
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surface, // Sesuaikan warna latar belakang
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
            // Gambar dengan ukuran dinamis
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(event.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Judul event
            Text(
              event.title!,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Lokasi event
            Text(
              event.location!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            // Tanggal event
            Text(
              '${event.date!.day}/${event.date!.month}', // Format tanggal
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            // Harga event (jika ada)
            Text(
              event.ticketPrice != null
                  ? 'Rp ${event.ticketPrice!.toStringAsFixed(2)}' // Format harga dengan 2 angka desimal
                  : 'Free', // Tampilkan 'Free' jika harga null
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
