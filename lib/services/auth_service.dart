import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static final String _backendUrl = 'http://10.0.2.2:5000/api/login';

  static Future<String> login(String empId, String password) async {
    final response = await http.post(
      Uri.parse(_backendUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"empId": empId, "password": password}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['status'] ?? 'N';
    } else {
      throw Exception("Server Error: ${response.statusCode}");
    }
  }
}
