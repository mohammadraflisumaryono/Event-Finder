// ignore_for_file: prefer_const_constructors

import 'package:event_finder/utils/routes/routes.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:event_finder/view_model/auth_view_model.dart';
import 'package:event_finder/view_model/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'res/theme.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => EventViewModel())
      ],
      child: MaterialApp(
        title: 'Event Finder',
        theme: AppTheme.lightTheme, // Menggunakan tema dari res/theme.dart
        initialRoute: RoutesName.OnboardingScreen, // Mulai dari halaman HomePage
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
