import 'package:flutter/material.dart';
import 'package:homepage/homepage.dart';
import 'package:homepage/mapview.dart';
import 'package:homepage/scannerhelp.dart';
import 'package:homepage/scannerinfo.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: "Brother Scanner",
                ));
      case '/scannerhelp':
        // Validation of correct data type
        return MaterialPageRoute(builder: (_) => ScannerHelpPage());
      case '/':
        // Validation of correct data type
        return MaterialPageRoute(builder: (_) => mapviewPage());
      case '/scannerinfo':
        // Validation of correct data type
        return MaterialPageRoute(builder: (_) => ScannerInfoPage());

      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
      //return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
