import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/response/status.dart';
import '../utils/utils.dart';
import '../view_model/event_view_model.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String eventId; // Tambahkan parameter untuk eventId

  const DetailPage({super.key, required this.eventId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final EventViewModel _eventViewModel = EventViewModel();

  @override
  void initState() {
    print("eventId: ${widget.eventId}");
    super.initState();
    // Panggil fetchEventById() dengan eventId yang diterima
    _eventViewModel.fetchEventById(widget.eventId);
  }

  Future<void> launchURL(String? url) async {
    if (url == null) return;

    final Uri uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      if (mounted) {
        Utils.toastMessage('Could not launch the registration link.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Event Details",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
        ),
      ),
      body: ChangeNotifierProvider<EventViewModel>(
        create: (BuildContext context) => _eventViewModel,
        child: Consumer<EventViewModel>(
          builder: (context, value, _) {
            switch (value.eventsList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());

              case Status.ERROR:
                return Center(
                  child: Text(
                    value.eventsList.message ?? 'An error occurred',
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                );

              case Status.COMPLETED:
                final event =
                    value.eventsList.data?.events?.first; // Ambil event pertama
                if (event == null) {
                  return const Center(
                    child: Text(
                      'Event not found',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
                return SingleChildScrollView(
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
                              right:
                                  16, // Tambahkan untuk menghindari teks melewati batas
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.title ?? "Event Title",
                                      style: GoogleFonts.outfit(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      softWrap: true, // Izinkan teks membungkus
                                      overflow: TextOverflow
                                          .visible, // Tampilkan teks penuh
                                    ),
                                  ],
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
                                  const Icon(Icons.location_on,
                                      color: Colors.purple, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      event.location ?? "Location",
                                      style: GoogleFonts.outfit(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.event,
                                      color: Colors.purple, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${event.date?.day ?? 0}/${event.date?.month ?? 0}/${event.date?.year ?? 0}",
                                    style: GoogleFonts.outfit(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.access_time,
                                      color: Colors.purple, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${event.time?.start?.hour.toString().padLeft(2, '0')}:${event.time?.start?.minute.toString().padLeft(2, '0')} - "
                                    "${event.time?.end?.hour.toString().padLeft(2, '0')}:${event.time?.end?.minute.toString().padLeft(2, '0')}",
                                    style: GoogleFonts.outfit(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.remove_red_eye,
                                      color: Colors.purple, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${event.views ?? 0} views",
                                    style: GoogleFonts.outfit(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Description Section
                      Text(
                        "Description",
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description ?? "No description available.",
                        style: GoogleFonts.outfit(
                            fontSize: 14, color: Colors.grey[800]),
                      ),
                      const SizedBox(height: 16),

                      // Price & Button Section
                      Card(
                        elevation: 4, // You can adjust the elevation as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Theme.of(context)
                            .colorScheme
                            .surface, // Background color
                        child: Container(
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
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    event.ticketPrice != null
                                        ? "Rp ${NumberFormat('#,###', 'id_ID').format(event.ticketPrice)}"
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
                                onPressed: () =>
                                    launchURL(event.registrationLink),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
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
                      ),
                    ],
                  ),
                );

              default:
                return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
