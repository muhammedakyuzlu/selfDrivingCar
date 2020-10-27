import 'package:SDC/screens/homeScreen.dart';
import 'package:flutter/material.dart';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      //HomeScreen
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        );

      // default
      default:
        return MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        );
    }
  }
}
