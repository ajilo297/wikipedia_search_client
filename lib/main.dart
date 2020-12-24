import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/locator.dart';
import 'core/router_constants.dart';
import 'core/router.dart' as router;

void main() async {
  await LocatorInjector.setUpLocator();
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Color(0xff0645ad),
        primaryColor: Color(0xff0645ad),
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          color: Theme.of(context).cardColor,
          centerTitle: true,
        ),
        primaryTextTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme.copyWith(
                headline6: TextStyle(color: Colors.black),
              ),
        ),
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.black,
        ),
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: splashViewRoute,
    );
  }
}
