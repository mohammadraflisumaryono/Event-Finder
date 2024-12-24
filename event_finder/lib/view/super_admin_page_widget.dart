import 'package:flutter/material.dart';

class SuperAdminEventWidget extends StatelessWidget {
  final List<Map<String, dynamic>> events = [
    {
      "title": "Music Festival",
      "description": "A grand music festival with various artists performing.",
      "price": "IDR 500,000",
    },
    {
      "title": "Art Exhibition",
      "description": "Explore beautiful artworks by talented artists.",
      "price": "IDR 300,000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Super Admin Events'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(event['description']),
                  SizedBox(height: 8),
                  Text('Price: ${event['price']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
