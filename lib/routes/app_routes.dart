import 'package:flutter/material.dart';
import '../screens/login_page.dart';
import '../screens/dashboard_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => EmployeeLoginScreen(),
  '/dashboard': (context) => DashboardPage(),
};
