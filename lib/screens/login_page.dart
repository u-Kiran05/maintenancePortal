import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../styles/login_style.dart';
import '../styles/app_colors.dart';

class EmployeeLoginScreen extends StatefulWidget {
  @override
  State<EmployeeLoginScreen> createState() => _EmployeeLoginScreenState();
}

class _EmployeeLoginScreenState extends State<EmployeeLoginScreen> {
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _feedbackMessage = '';
  IconData? _feedbackIcon;
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _attemptLogin() async {
    final empId = _employeeIdController.text.trim();
    final password = _passwordController.text.trim();

    if (empId.isEmpty || password.isEmpty) {
      setState(() {
        _feedbackIcon = Icons.warning_amber;
        _feedbackMessage = "Please enter both Employee ID and Password";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _feedbackMessage = '';
      _feedbackIcon = null;
    });

    try {
      final status = await AuthService.login(empId, password);
      if (status == 'Y') {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        setState(() {
          _feedbackIcon = Icons.error;
          _feedbackMessage = "Invalid credentials. Try again.";
        });
      }
    } catch (error) {
      setState(() {
        _feedbackIcon = Icons.report_problem;
        _feedbackMessage = "Login failed: $error";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLeft,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(30),
          decoration: LoginStyles.cardBox,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.engineering, size: 60, color: Colors.blueAccent),
              const SizedBox(height: 10),

              // ✅ No const here because the style is not compile-time constant
              Text("Maintenance Engineer Login", style: LoginStyles.titleText),

              const SizedBox(height: 20),
              TextField(
                controller: _employeeIdController,
                decoration: LoginStyles.inputDecoration("Employee ID", Icons.badge),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: LoginStyles.inputDecoration(
                  "Password",
                  Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _attemptLogin,
                  icon: const Icon(Icons.login),
                  label: const Text("Login"),
                  style: LoginStyles.loginButtonStyle,
                ),
              ),
              const SizedBox(height: 15),
              if (_feedbackMessage.isNotEmpty)
                Row(
                  children: [
                    Icon(_feedbackIcon ?? Icons.info, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _feedbackMessage,
                        style: LoginStyles.errorText,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
