// ignore_for_file: prefer_const_constructors

import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../model/events_model.dart';
import '../model/status_event.dart';
import '../view_model/auth_view_model.dart';
import '../view_model/event_view_model.dart';
import '../view_model/user_preferences.dart';
import '../widgets/event_card_organizer.dart';

class HomeAdminEventPage extends StatefulWidget {
  final bool isOrganizer;

  HomeAdminEventPage({required this.isOrganizer});

  @override
  _HomeAdminEventPageState createState() => _HomeAdminEventPageState();
}

class _HomeAdminEventPageState extends State<HomeAdminEventPage> {
  late String userId;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndFetchEvents();
  }

  // Memuat userId dari SharedPreferences dan fetch event
  void _loadUserIdAndFetchEvents() async {
    String? fetchedUserId = await UserPreferences.getUserId();
    if (fetchedUserId != null) {
     if (mounted) {
      setState(() {
        userId = fetchedUserId;
      });
    }
    await Provider.of<EventViewModel>(context, listen: false)
        .fetchAndCategorizeEvents(userId);
    } else {
      print('User is not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(
              8.0), // Memberikan padding agar logo terlihat lebih rapi
          child: Image.asset(
            'lib/res/assets/images/logogoova.png', // Ganti dengan path logo aplikasi Anda
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          'Organizer Events Dashboard',
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Untuk memastikan teks berada di tengah
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.login);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple, // Latar belakang ungu
                  shape: BoxShape
                      .circle, // Membuat ikon menjadi berbentuk lingkaran
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Memberikan ruang di sekitar ikon
                  child: Image.asset(
                    'lib/res/assets/images/logout.png', 
                    width: 18, 
                    height: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Consumer<EventViewModel>(
            builder: (context, eventViewModel, child) {
              if (eventViewModel.eventsList.status == Status.LOADING) {
                print('loading..');
                return Center(child: CircularProgressIndicator());
              }

              if (eventViewModel.eventsList.status == Status.ERROR) {
                return Center(
                    child: Text('Error: ${eventViewModel.eventsList.message}'));
              }

              final categorizedEvents =
                  eventViewModel.eventsList.data?.events ?? [];

              print(categorizedEvents);

              // Pastikan categorizedEvents memiliki data
              if (categorizedEvents.isEmpty) {
                return Center(child: Text('No Events are Created'));
              }

              // Mengelompokkan events berdasarkan status
              final Map<StatusEvent, List<Event>> categorizedEventsMap = {
                StatusEvent.approved: [],
                StatusEvent.pending: [],
                StatusEvent.rejected: [],
                StatusEvent.expired: []
              };

              for (var event in categorizedEvents) {
                if (event.status != null) {
                  categorizedEventsMap[event.status!]!.add(event);
                }
              }

              // Menyortir setiap kategori event berdasarkan tanggal
              categorizedEventsMap.forEach((status, events) {
                events.sort((a, b) => a.date!.compareTo(b.date!));
              });

              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Menampilkan event berdasarkan status
                  buildEventSection('Approved Events',
                      categorizedEventsMap[StatusEvent.approved]),
                  buildEventSection('Pending Events',
                      categorizedEventsMap[StatusEvent.pending]),
                  buildEventSection('Rejected Events',
                      categorizedEventsMap[StatusEvent.rejected]),
                  buildEventSection('Expired Events',
                      categorizedEventsMap[StatusEvent.expired]),
                ],
              );
            },
          ),

          // Tombol bulat di pojok kanan bawah
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.createEvent);
              },
              backgroundColor: Colors.purple,
              elevation: 10, // Menambahkan efek elevated
              child: ClipOval(
                child: Image.asset(
                  'lib/res/assets/images/add.png',
                  fit: BoxFit.cover,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan event berdasarkan status
  Widget buildEventSection(String title, List<Event>? events) {
  // Jika tidak ada event untuk status tersebut, tidak perlu menampilkannya
  if (events == null || events.isEmpty) return SizedBox.shrink();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      SizedBox(height: 16),
      // Menampilkan list event
      ListView.builder(
        shrinkWrap: true, // Gunakan shrinkWrap agar tidak mempengaruhi scroll
        physics: NeverScrollableScrollPhysics(),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventCardOrganizer(
            isOrganizer: true, 
            event: events[index],
            userId: userId,
          );
        },
      ),
      SizedBox(height: 16),
    ],
  );
}
}

class EventCardOrganizer extends StatelessWidget {
  final bool isOrganizer;
  final Event event;
  final String userId;

  EventCardOrganizer({
    required this.isOrganizer,
    required this.event,
    required this.userId, // Parameter baru
  });

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
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
                        builder: (context) => EditEventDialog(event: event),
                      );
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
                    onPressed: event.id == null
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
                                        try {
                                          // Panggil fungsi untuk menghapus event
                                          await Provider.of<EventViewModel>(
                                                  context,
                                                  listen: false)
                                              .deleteEventById(
                                            id: event.id!,
                                            organizerId:
                                                UserPreferences.userIdKey,
                                            context: context,
                                          );
                                        } catch (error) {
                                          print('Error: $error');
                                          // Tampilkan snackbar atau dialog untuk memberi tahu pengguna
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Failed to delete event: $error')),
                                          );
                                        }
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

class EditEventDialog extends StatelessWidget {
  final Event event; // Menerima event yang akan diedit

  EditEventDialog({required this.event}); // Constructor untuk menerima event

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Event'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Event Name TextField, diisi dengan nama event saat ini
            TextField(
              controller: TextEditingController(
                  text: event.title), // Menampilkan nama event yang ada
              decoration: InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Event Description TextField, diisi dengan deskripsi event saat ini
            TextField(
              controller: TextEditingController(
                  text: event
                      .description), // Menampilkan deskripsi event yang ada
              decoration: InputDecoration(
                labelText: 'Event Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            // Ticket Price TextField, diisi dengan harga tiket event saat ini
            TextField(
              controller: TextEditingController(
                  text: event.ticketPrice
                      ?.toString()), // Menampilkan harga tiket yang ada
              decoration: InputDecoration(
                labelText: 'Ticket Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Logika untuk menyimpan perubahan
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Event Updated')),
            );
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
