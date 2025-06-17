import 'package:flutter/material.dart';
import '../styles/dashboard_styles.dart';
import '../styles/app_colors.dart';
import '../utils/user_session.dart';
import 'notifications_page.dart';
import 'workorder_page.dart';

class DashboardPage extends StatefulWidget {
  final String empId;

  const DashboardPage({Key? key, required this.empId}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pages = [
      NotificationsPage(empId: widget.empId),
      WorkOrderPage(empId: widget.empId),
      const SizedBox(), // Logout placeholder
    ];
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) async {
    if (index == 2) {
      await UserSession.clear();
      Navigator.pushReplacementNamed(context, '/');
    } else {
      setState(() {
        _selectedIndex = index;
        _animationController.reset();
        _animationController.forward();
      });
    }
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Notifications';
      case 1:
        return 'Work Orders';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 2
          ? null
          : AppBar(
        title: Row(
          children: [
            Text(_getAppBarTitle(_selectedIndex)),
            const Spacer(),
            Text(
              'ID: ${widget.empId}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryRed,
        elevation: 4,
        shadowColor: AppColors.primaryRed.withOpacity(0.4),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryRed,
                AppColors.darkRedText,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundLeft,
              AppColors.primaryRed.withOpacity(0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.primaryRed,
          unselectedItemColor: AppColors.darkRedText.withOpacity(0.6),
          backgroundColor: AppColors.white.withOpacity(0.95),
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications, size: 28),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryRed.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications, size: 28),
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment, size: 28),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryRed.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.assignment, size: 28),
              ),
              label: 'Work Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout, size: 28),
              activeIcon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryRed.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout, size: 28),
              ),
              label: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}