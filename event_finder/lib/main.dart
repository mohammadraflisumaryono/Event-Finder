import 'package:event_finder/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel())
      ],
      child: MaterialApp(
      title: 'Event Finder',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: RoutesName.login, // Mulai dari halaman HomePage
      onGenerateRoute: Routes.generateRoute,
    ),
      );
  }
}
