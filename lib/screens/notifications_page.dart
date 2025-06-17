import 'package:flutter/material.dart';
import '../services/other_services.dart';
import '../styles/app_colors.dart';
import '../styles/notification_styles.dart';

class NotificationsPage extends StatefulWidget {
  final String empId;
  const NotificationsPage({required this.empId, Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Future<List<Map<String, dynamic>>> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = OtherServices.fetchNotifications(widget.empId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _notifications,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No notifications found'));
        }

        final items = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final notif = items[index];
            return Card(
              margin: NotificationStyles.cardMargin,
              elevation: 3,
              shape: NotificationStyles.cardShape,
              child: Padding(
                padding: NotificationStyles.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification: ${notif['Qmnum']}",
                      style: NotificationStyles.titleText,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notif['Qmtxt'] ?? '',
                      style: NotificationStyles.bodyText,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Priority: ${notif['Priok']}  Date: ${notif['Qmdat']}  Start: ${notif['Strmn']}",
                      style: NotificationStyles.metaText,
                    ),
                    Text(
                      "Equip: ${notif['Equnr']}  FLoc: LOC01",
                      style: NotificationStyles.metaText,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
