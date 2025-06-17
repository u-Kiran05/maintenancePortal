import 'package:flutter/material.dart';
import 'routes/app_routes.dart'; // Route definitions

void main() {
  runApp(MaintenanceApp());
}

class MaintenanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAP Maintenance Portal',
      initialRoute: '/',
      routes: appRoutes, // Defined in app_routes.dart
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Roboto',
      ),
    );
  }
}
