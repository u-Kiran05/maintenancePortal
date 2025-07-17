import 'package:flutter/material.dart';
import 'package:maintenance_portal/services/counter.dart';
import 'package:maintenance_portal/utils/user_session.dart';
import 'package:maintenance_portal/styles/app_colors.dart'; // ✅ Use shared AppColors

class MaintenanceDashboard extends StatefulWidget {
  @override
  _MaintenanceDashboardState createState() => _MaintenanceDashboardState();
}

class _MaintenanceDashboardState extends State<MaintenanceDashboard> {
  int notificationCount = 0;
  int workOrderCount = 0;
  String empId = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeDashboard();
  }

  Future<void> initializeDashboard() async {
    final id = await UserSession.getEmpId();
    if (id != null && id.isNotEmpty) {
      setState(() => empId = id);
      await fetchCounts();
    } else {
      print('No empId found');
      // Optionally redirect to login
    }
  }

  Future<void> fetchCounts() async {
    try {
      setState(() => isLoading = true);
      final notif = await ApiService.getNotificationCount(empId);
      final work = await ApiService.getWorkOrderCount(empId);
      setState(() {
        notificationCount = notif;
        workOrderCount = work;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching counts: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintenance Overview',
          style: TextStyle(color: AppColors.darkRedText),
        ),
        backgroundColor: AppColors.backgroundLeft,
      ),
      body: Container(
        color: AppColors.backgroundLeft,
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.primaryRed))
            : RefreshIndicator(
          onRefresh: fetchCounts,
          color: AppColors.primaryRed,
          backgroundColor: AppColors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSquareCard(
                  'Notifications',
                  notificationCount,
                  AppColors.primaryRed,
                  Icons.notifications,
                ),
                SizedBox(height: 20),
                buildSquareCard(
                  'Work Orders',
                  workOrderCount,
                  AppColors.primaryRed,
                  Icons.work,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSquareCard(String title, int count, Color color, IconData icon) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(icon, color: AppColors.white, size: 30),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: AppColors.darkRedText,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '$count',
            style: TextStyle(
              color: AppColors.darkRedText,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
