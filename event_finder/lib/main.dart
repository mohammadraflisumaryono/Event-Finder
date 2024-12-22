import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:
          RoutesName.createAccount, // Mulai dari halaman Create Account
      onGenerateRoute: Routes.generateRoute, // Gunakan routing dinamis
    );
  }
}
