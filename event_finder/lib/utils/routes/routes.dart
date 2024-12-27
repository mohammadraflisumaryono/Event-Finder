// ignore_for_file: prefer_const_constructors
import 'package:event_finder/view/create_event_page.dart';
import 'package:event_finder/view/details_page_widget.dart';
import 'package:event_finder/view/home_admin_event_widget.dart';
import 'package:event_finder/view/home_page.dart';
import 'package:event_finder/view/onboarding_screen.dart';
import 'package:event_finder/view/super_admin_page_widget.dart';
import 'package:event_finder/widgets/edit_event_dialog.dart';
import 'package:flutter/material.dart';
import '../../view/login_page_widget.dart'; // Login Page
import '../../view/create_account_page_widget.dart'; // Register Page
import 'routes_name.dart'; // Route names

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.onboardingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomePage());
      case RoutesName.detailEvent:
        final String eventId = settings.arguments as String;
        print('eventid: ${settings.arguments}');
        return MaterialPageRoute(
            builder: (context) => DetailPage(eventId: eventId));
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginPageWidget());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (context) => CreateAccountPageWidget());
      case RoutesName.adminHome:
        return MaterialPageRoute(
            builder: (context) => HomeAdminEventPage(isOrganizer: true));
      case RoutesName.createEvent:
        return MaterialPageRoute(builder: (context) => CreateEventPage());
      case RoutesName.EditEventDialog:
        return MaterialPageRoute(builder: (context) => EditEventDialog());
      case RoutesName.superAdmin:
        return MaterialPageRoute(builder: (context) => SuperAdminEventWidget());
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
