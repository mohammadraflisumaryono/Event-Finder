// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/events_model.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menerima data Event yang dikirim melalui Navigator.pushNamed
    final Event? event = ModalRoute.of(context)?.settings.arguments as Event?;
    print(ModalRoute.of(context)?.settings.arguments);

    if (event == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(
          child: Text(
            'Event data is missing!',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    // Fungsi untuk membuka URL (registration link)
    Future<void> _launchURL() async {
      final Uri url = Uri.parse(event.registrationLink ?? '');
      if (await canLaunch(url.toString())) {
        await launch(url.toString());
      } else {
        // Jika URL tidak bisa dibuka, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Could not launch the registration link.")));
      }
    }
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Event Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.network(
                    event.image ??
                        "https://via.placeholder.com/600x300?text=Event+Image",
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        event.title ?? "Event Title",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Event Info Card
            Card(
              margin: EdgeInsets.zero,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.purple, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            event.location ?? "Location",
                            style: GoogleFonts.outfit(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.event, color: Colors.purple, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "${event.date?.day ?? 0}/${event.date?.month ?? 0}/${event.date?.year ?? 0}",
                          style: GoogleFonts.outfit(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.people, color: Colors.purple, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "${event.time?.start ?? "Start"} - ${event.time?.end ?? "End"}",
                          style: GoogleFonts.outfit(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.people, color: Colors.purple, size: 20),
                        SizedBox(width: 8),
                        Text(
                          event.views.toString(),
                          style: GoogleFonts.outfit(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Description Section
            Text(
              "Description",
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              event.description ?? "No description available.",
              style: GoogleFonts.outfit(fontSize: 14, color: Colors.grey[800]),
            ),
            SizedBox(height: 16),

            // Price & Button Section
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start from",
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        event.ticketPrice != null
                            ? "Rp ${event.ticketPrice!.toStringAsFixed(2)}"
                            : "Free", 
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _launchURL, // Membuka URL pendaftaran
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      backgroundColor:
                          Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Join Event",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}