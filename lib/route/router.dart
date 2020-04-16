import 'package:flutter/material.dart';
import 'package:productivityio/screens/wrapper.dart';

class Router {
  static Route<dynamic> createRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (_) => Wrapper(route: settings.name));
    }
  }
}