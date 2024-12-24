import 'package:flutter/material.dart';

class SearchResultPageWidget extends StatelessWidget {
  final String query;

  SearchResultPageWidget({required this.query});

  @override
  Widget build(BuildContext context) {
    // Contoh data event yang bisa Anda cari
    List<String> eventList = [
      'Coldplay: Music of the Spheres',
      'Muse: Will of the People',
      'One Direction: Where We Are',
      'The Beatles: Revival Concert'
    ];

    // Filter event berdasarkan query
    List<String> filteredEvents = eventList
        .where((event) => event.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredEvents[index]),
            onTap: () {
              // Aksi ketika salah satu event dipilih
            },
          );
        },
      ),
    );
  }
}
