import 'package:flutter/material.dart';
import '../../view/login_page_widget.dart'; // Login Page
import '../../view/home_page_widget.dart'; // Home Page
import '../../view/create_account_page_widget.dart'; // Register Page
import '../../view/main_page.dart'; // Main Page
import 'routes_name.dart'; // Route names

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => LoginPageWidget(),
        );

      case RoutesName.register:
        return MaterialPageRoute(
          builder: (context) => CreateAccountPageWidget(),
        );

      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => const HomePageWidget(),
        );

      case RoutesName.main: // Tetap arahkan ke MainPage
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );

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