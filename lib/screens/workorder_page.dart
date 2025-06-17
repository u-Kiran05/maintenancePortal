import 'package:flutter/material.dart';
import '../services/other_services.dart';
import '../styles/app_colors.dart';
import '../styles/workorder_styles.dart';

class WorkOrderPage extends StatefulWidget {
  final String empId;

  const WorkOrderPage({required this.empId, Key? key}) : super(key: key);

  @override
  State<WorkOrderPage> createState() => _WorkOrderPageState();
}

class _WorkOrderPageState extends State<WorkOrderPage> {
  late Future<List<Map<String, dynamic>>> _futureWorkOrders;

  @override
  void initState() {
    super.initState();
    _futureWorkOrders = OtherServices.fetchWorkOrders(widget.empId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureWorkOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No work orders found'));
        }

        final workOrders = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: workOrders.length,
          itemBuilder: (context, index) {
            final wo = workOrders[index];
            return Card(
              margin: WorkOrderStyles.cardMargin,
              elevation: WorkOrderStyles.cardElevation,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${wo['Aufnr']} - ${wo['Ktext']}',
                      style: WorkOrderStyles.titleTextStyle,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Type: ${wo['Auart']} | Assigned by: ${wo['Ernam']}',
                      style: WorkOrderStyles.subtitleTextStyle,
                    ),
                    Text(
                      'Start: ${wo['Gstrp']} | Entry: ${wo['Erdat']}',
                      style: WorkOrderStyles.subtitleTextStyle,
                    ),
                    Text(
                      'Plant: ${wo['Sowrk']} | Company: ${wo['Bukrs']}',
                      style: WorkOrderStyles.subtitleTextStyle,
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
