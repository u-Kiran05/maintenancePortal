import 'package:flutter/material.dart';
import '../utils/user_session.dart';
import '../styles/app_colors.dart';
import '../styles/dashboard_styles.dart';
import 'notifications_page.dart';

class DashboardPage extends StatelessWidget {
  void _navigate(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final empId = UserSession.getEmpId();

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"), backgroundColor: AppColors.primaryRed),
      backgroundColor: AppColors.backgroundLeft,
      body: Padding(
        padding: DashboardStyles.gridPadding,
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _DashboardCard(
              title: 'Notifications',
              icon: Icons.notification_important_outlined,
              onTap: () => _navigate(context, NotificationsPage(empId: empId)),
            ),
            _DashboardCard(
              title: 'Work Orders',
              icon: Icons.build_circle_outlined,
              onTap: () {}, // future screen
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DashboardCard({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.primaryRed.withOpacity(0.2),
      child: Card(
        elevation: 4,
        color: DashboardStyles.cardBackgroundColor,
        shape: DashboardStyles.cardShape,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: DashboardStyles.iconSize, color: DashboardStyles.cardIconColor),
              SizedBox(height: 12),
              Text(title, style: DashboardStyles.cardTitleStyle),
            ],
          ),
        ),
      ),
    );
  }
}
