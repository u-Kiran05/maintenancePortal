class UserSession {
  static String? _empId;

  static Future<void> setEmpId(String empId) async {
    _empId = empId;
  }

  static Future<String?> getEmpId() async {
    return _empId;
  }

  static Future<void> clear() async {
    _empId = null;
  }
}
