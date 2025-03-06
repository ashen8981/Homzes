import 'package:flutter/material.dart';
import 'package:homzes_app/presentation/screens/search_catalog_1.dart';
import 'package:homzes_app/presentation/screens/welcome_screen.dart';
import '../../presentation/screens/search_catalog_3.dart';

class Routes {
  static const String welcome = '/';
  static const String searchCatalog1 = '/searchCatalog1';
  static const String searchCatalog3 = '/searchCatalog3';
}

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case Routes.searchCatalog1:
        return MaterialPageRoute(builder: (_) => SearchCatalog1Screen());
      case Routes.searchCatalog3:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SearchCatalog3Screen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      default:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
    }
  }
}
