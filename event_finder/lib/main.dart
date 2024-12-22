import 'package:event_finder/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './utils/routes/routes.dart'; // Routes logic
import './utils/routes/routes_name.dart'; // Routes names

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
