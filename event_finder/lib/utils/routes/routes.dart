// ignore_for_file: prefer_const_constructors
import 'package:event_finder/view/create_event_page.dart';
import 'package:event_finder/view/details_page_widget.dart';
import 'package:event_finder/view/home_admin_event_widget.dart';
import 'package:event_finder/view/home_page.dart';
import 'package:event_finder/view/search_result_page_widget.dart';
import 'package:event_finder/view/super_admin_page_widget.dart';
import 'package:flutter/material.dart';
import '../../view/login_page_widget.dart'; // Login Page
import '../../view/create_account_page_widget.dart'; // Register Page
import 'routes_name.dart'; // Route names

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomePage());
      case RoutesName.search:
        return MaterialPageRoute(
            builder: (context) => SearchResultPageWidget(query: ''));
      //case RoutesName.detailEvent:
       // return MaterialPageRoute(builder: (context) => DetailPage());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginPageWidget());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (context) => CreateAccountPageWidget());
      case RoutesName.adminHome:
        return MaterialPageRoute(
            builder: (context) => HomeAdminEventPage(isAdmin: true));
      case RoutesName.createEvent:
        return MaterialPageRoute(builder: (context) => CreateEventPage());
      // case RoutesName.superAdmin:
      //   return MaterialPageRoute(builder: (context) => SuperAdminEventWidget());
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
