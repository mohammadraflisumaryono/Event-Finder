// ignore_for_file: prefer_const_constructors
import 'package:event_finder/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'res/theme.dart';
import 'view/home_page_widget.dart';

void main() {
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
        theme: AppTheme.lightTheme, // Menggunakan tema dari res/theme.dart
        home: HomePageWidget(), // Memulai dari halaman HomePage
      ),
    );
  }
}
