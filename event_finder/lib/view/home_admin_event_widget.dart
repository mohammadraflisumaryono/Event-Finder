// ignore_for_file: prefer_const_constructors

import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../model/events_model.dart';
import '../model/status_event.dart';
import '../view_model/event_view_model.dart';
import '../widgets/event_card_organizer.dart';

class HomeAdminEventPage extends StatelessWidget {
  final bool isAdmin;

  HomeAdminEventPage({required this.isAdmin});

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
          // Consumer untuk menampilkan data event
          Consumer<EventViewModel>(
            builder: (context, eventViewModel, child) {
              // Menunggu data event dikategorikan berdasarkan status
              if (eventViewModel.eventsList.status == Status.LOADING) {
                return Center(child: CircularProgressIndicator());
              }

              // Jika ada error
              if (eventViewModel.eventsList.status == Status.ERROR) {
                return Center(
                    child: Text('Error: ${eventViewModel.eventsList.message}'));
              }

              final categorizedEvents =
                  eventViewModel.eventsList.data?.events ?? [];

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
            isAdmin: true, 
            event: events[index],
          );
        },
      ),
      SizedBox(height: 16),
    ],
  );
}
}