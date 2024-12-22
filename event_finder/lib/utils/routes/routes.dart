// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../../view/login_page_widget.dart';
import '../../view/home_page_widget.dart';
import '../../view/create_account_page_widget.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginPageWidget());
      case RoutesName.register:
        return MaterialPageRoute(builder: (context) => const CreateAccountPageWidget());
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomePageWidget());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

// Corrected HomePageWidget class definition
class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Welcome to the Home Page!')),
    );
  }
}