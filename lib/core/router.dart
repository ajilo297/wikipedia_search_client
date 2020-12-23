// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:wikipedia_search/core/router_constants.dart';

import 'package:wikipedia_search/views/splash/splash_view.dart' as view0;
import 'package:wikipedia_search/views/home/home_view.dart' as view1;
import 'package:wikipedia_search/views/search/search_view.dart' as view2;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashViewRoute:
        return MaterialPageRoute(builder: (_) => view0.SplashView());
      case homeViewRoute:
        return MaterialPageRoute(builder: (_) => view1.HomeView());
      case searchViewRoute:
        return MaterialPageRoute(builder: (_) => view2.SearchView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}