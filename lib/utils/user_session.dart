class UserSession {
  static String? empId;

  static void setEmpId(String id) => empId = id;
  static String getEmpId() => empId ?? '';
  static void clear() => empId = null;
}
