import 'package:flutter/material.dart';
import './utils/routes/routes.dart'; // Routes logic
import './utils/routes/routes_name.dart'; // Routes names

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,

      // Tetapkan MainPage sebagai halaman awal
      initialRoute: RoutesName.main,

      // Generate rute sesuai dengan Routes.dart
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
