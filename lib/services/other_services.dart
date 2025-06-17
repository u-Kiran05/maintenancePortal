import 'package:http/http.dart' as http;
import 'dart:convert';

class OtherServices {
  static final String _baseUrl = 'http://10.0.2.2:5000/api';

  // --- NOTIFICATIONS ---
  static Future<List<Map<String, dynamic>>> fetchNotifications(String empId) async {
    final response = await http.get(Uri.parse('$_baseUrl/notifications/$empId'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success'] == true) {
        return List<Map<String, dynamic>>.from(result['data']);
      } else {
        throw Exception("No notifications found");
      }
    } else {
      throw Exception("Server error: ${response.statusCode}");
    }
  }

  // --- WORK ORDERS ---
  static Future<List<Map<String, dynamic>>> fetchWorkOrders(String empId) async {
    final response = await http.get(Uri.parse('$_baseUrl/workorders/$empId'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success'] == true) {
        return List<Map<String, dynamic>>.from(result['data']);
      } else {
        throw Exception("No work orders found");
      }
    } else {
      throw Exception("Server error: ${response.statusCode}");
    }
  }
}
