import 'package:flutter/material.dart';
import '../screens/login_page.dart';
import '../screens/dashboard_page.dart';
import '../screens/notifications_page.dart';
import '../screens/workorder_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const EmployeeLoginScreen());

    case '/dashboard':
      final empId = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => DashboardPage(empId: empId));

    case '/notifications':
      final empId = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => NotificationsPage(empId: empId));

    case '/workorders':
      final empId = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => WorkOrderPage(empId: empId));

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      );
  }
}
