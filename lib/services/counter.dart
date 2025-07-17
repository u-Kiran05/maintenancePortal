import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://10.0.2.2:5000/api';

  static Future<int> getNotificationCount(String empId) async {
    final url = Uri.parse('$baseUrl/notifications/$empId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['success'] && data['data'] != null) ? data['data'].length : 0;
    } else {
      throw Exception('Failed to fetch notifications');
    }
  }

  static Future<int> getWorkOrderCount(String empId) async {
    final url = Uri.parse('$baseUrl/workorders/$empId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['success'] && data['data'] != null) ? data['data'].length : 0;
    } else {
      throw Exception('Failed to fetch work orders');
    }
  }
}
