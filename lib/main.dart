import 'package:flutter/material.dart';
import 'routes/app_routes.dart'; // Contains the generateRoute function

void main() {
  runApp(MaintenanceApp());
}

class MaintenanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAP Maintenance Portal',
      initialRoute: '/',
      onGenerateRoute: generateRoute, // <-- use this
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Roboto',
      ),
    );
  }
}
