import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:maintenance_portal/main.dart';

void main() {
  testWidgets('Employee Login screen renders correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MaintenanceApp());

    // Look for text fields
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.widgetWithText(TextField, 'Employee ID'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    // Look for the Login button
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // Look for AppBar title
    expect(find.text('Employee Login'), findsOneWidget);
  });
}
