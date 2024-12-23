// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:event_finder/model/event_category.dart';
import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/event_time.dart';
import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';

import 'package:event_finder/repository/event_repository.dart';

void main() async {
  // final eventRepository = EventRepository();
  //  try {
  //   final events = await eventRepository.getAllEvents();
  //   print(events); // Cetak hasil response
  // } catch (e) {
  //   print('Error fetching events: $e');
  // }

  // Membuat objek Event
  Event event = Event(
    id: '123',
    title: 'Concert Rock Band',
    date: DateTime.parse('2024-12-25T19:00:00Z'),
    time: EventTime(start: DateTime.parse('2024-12-25T19:00:00Z'), end: DateTime.parse('2024-12-25T22:00:00Z')),
    location: 'Stadium ABC, Jakarta',
    description: 'A grand concert featuring top rock bands.',
    image: 'concert-poster.jpg',
    category: EventCategory.concert,
    ticketPrice: 100000,
    registrationLink: 'https://www.event.com/register',
  );

  // Konversi event ke format JSON
  String jsonString = jsonEncode(event.toJson());
  
  // Cetak hasil JSON
  print(jsonString); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: MaterialApp(
        title: 'Event Finder',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.login, // Mulai dari halaman HomePage
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
