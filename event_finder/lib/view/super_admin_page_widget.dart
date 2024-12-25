// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SuperAdminEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Manage Events',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // const EventCard(),
          // const EventCard(),
        ],
      ),
    );
  }
}
