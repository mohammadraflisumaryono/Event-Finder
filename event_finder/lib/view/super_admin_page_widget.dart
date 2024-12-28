// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../model/events_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/event_view_model.dart';
import '../view_model/user_preferences.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.purple),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading:
            false, // Menonaktifkan tombol kembali otomatis
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Menampilkan dialog konfirmasi logout
                _showLogoutDialog(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.purple, // Latar belakang ungu
                  shape: BoxShape
                      .circle, // Membuat ikon menjadi berbentuk lingkaran
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                      8.0), // Memberikan ruang di sekitar ikon
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
      body: Container(
        color: Theme.of(context)
            .colorScheme
            .surface, // Background menggunakan tema
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo di tengah
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/res/assets/images/logogoova.png',
                        width: 50, // Ukuran logo
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Manage Event',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Event List',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<EventViewModel>(
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
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: eventList.length,
                      itemBuilder: (context, index) {
                        final event = eventList[index];
                        return EventCard(
                            event: event, eventViewModel: eventViewModel);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
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
    return GestureDetector(
      onTap: () {
        // Menampilkan dialog detail event
        showDialog(
          context: context,
          builder: (context) => EventDetailDialog(event: event),
        );
      },
      child: Card(
        color: Colors.white, // Warna background putih
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
                DateFormat('MMM dd, yyyy').format(event.date ?? DateTime.now()),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Status : Pending',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD2691E), // Warna orange ke coklatan
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Menampilkan dialog loading sebelum memulai proses
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Dialog tidak bisa ditutup dengan cara lain
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20),
                                  Text('Processing...'), // Teks loading
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      try {
                        // Memanggil fungsi update status event dengan status 'approved'
                        await eventViewModel.updateEventStatus(event.id, 'approved');

                        // Menutup dialog loading setelah proses selesai
                        Navigator.of(context).pop();
                        Utils.toastMessage('Event has been approved');
                      } catch (error) {
                        Navigator.of(context).pop();
                        print(error.toString());

                        Utils.toastMessage('Failed to approve event');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon:
                        const Icon(Icons.check, size: 18, color: Colors.white),
                    label: const Text(
                      'Approve',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Menampilkan dialog loading sebelum memulai proses
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Dialog tidak bisa ditutup dengan cara lain
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20),
                                  Text('Processing...'), // Teks loading
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      try {
                        // Memanggil fungsi update status event dengan status 'rejected'
                        await eventViewModel.updateEventStatus(event.id, 'rejected');

                        // Menutup dialog loading setelah proses selesai
                        Navigator.of(context).pop();
                        Utils.toastMessage('Event has been rejected');
                      } catch (error) {
                        // Menutup dialog loading jika ada error
                        Navigator.of(context).pop();
                        Utils.toastMessage('Failed to reject event');
                        print(error.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon:
                        const Icon(Icons.close, size: 18, color: Colors.white),
                    label: const Text(
                      'Reject',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventDetailDialog extends StatelessWidget {
  final Event event;

  EventDetailDialog({required this.event});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Event Details',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'ID : ${event.id ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Title : ${event.title ?? 'No Title'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Date : ${DateFormat('MMM dd, yyyy').format(event.date ?? DateTime.now())}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              "Time : ${event.time?.start?.hour.toString().padLeft(2, '0')}:${event.time?.start?.minute.toString().padLeft(2, '0')} - "
              "${event.time?.end?.hour.toString().padLeft(2, '0')}:${event.time?.end?.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Location : ${event.location ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Description : ${event.description ?? 'No Description'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Category : ${event.category?.name ?? 'Uncategorized'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Ticket Price : ${event.ticketPrice != null ? 'Rp ${NumberFormat('#,###', 'id_ID').format(event.ticketPrice)}' : 'Free'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Registration Link : ${event.registrationLink ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status : ${event.status?.name ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Views : ${event.views ?? 0}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple, // Warna ungu
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Radius sudut tombol
              ),
            ),
            child: const Text(
              'Back',
              style: TextStyle(
                color: Colors.white, // Warna teks putih
                fontSize: 16, // Ukuran font
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Fungsi untuk menampilkan dialog konfirmasi logout
void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Log Out'),
        content: Text('Are you sure you want to log out?'),
        contentPadding:
            const EdgeInsets.all(16.0), // Menambahkan padding di sekitar teks
        actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0), // Menambahkan jarak antara teks dan tombol
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Menutup dialog jika user memilih "Cancel"
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                  RoutesName.login); // Arahkan ke login setelah logout
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

// Fungsi untuk melakukan logout
void _performLogout(BuildContext context) async {
  try {
    // Hapus data dari SharedPreferences
    await UserPreferences.clearUserData();

    // Tampilkan pesan sukses
    Utils.toastMessage('Logged out successfully');

    // Navigasi ke halaman login
    Navigator.pushNamedAndRemoveUntil(
      context, RoutesName.login,
      (route) => false, // Hapus semua halaman sebelumnya dari stack
    );
  } catch (e) {
    Utils.toastMessage('Logout failed');
    print('Error during logout: $e');
  }
}
