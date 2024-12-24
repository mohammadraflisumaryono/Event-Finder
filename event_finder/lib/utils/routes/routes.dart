// ignore_for_file: prefer_const_constructors
import 'package:event_finder/view/create_event_page_widget.dart'
    as create_event;
import 'package:event_finder/view/home_admin_event_widget.dart';
import 'package:flutter/material.dart';
import '../../view/login_page_widget.dart'; // Login Page
import '../../view/home_page_widget.dart'; // Home Page
import '../../view/create_account_page_widget.dart'; // Register Page
import 'routes_name.dart'; // Route names

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomePageWidget());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginPageWidget());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (context) => CreateAccountPageWidget());
      case RoutesName.adminHome:
        return MaterialPageRoute(
            builder: (context) => HomeAdminEventPage(isAdmin: true));
      case RoutesName.createEvent:
        return MaterialPageRoute(
            builder: (context) => create_event.CreateEventPage());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
    }
  }
}
