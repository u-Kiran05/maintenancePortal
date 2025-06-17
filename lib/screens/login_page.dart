import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../styles/login_style.dart';
import '../styles/app_colors.dart';
import '../utils/user_session.dart';

class EmployeeLoginScreen extends StatefulWidget {
  const EmployeeLoginScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeLoginScreen> createState() => _EmployeeLoginScreenState();
}

class _EmployeeLoginScreenState extends State<EmployeeLoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _feedbackMessage = '';
  IconData? _feedbackIcon;
  bool _isLoading = false;
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _employeeIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
        await UserSession.setEmpId(empId);
        Navigator.pushReplacementNamed(context, '/dashboard', arguments: empId);
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
        child: Center(
          child: SingleChildScrollView(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                padding: const EdgeInsets.all(32),
                decoration: LoginStyles.cardBox,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo or image placeholder
                    Image.asset(
                      'assets/images/logo.png', // Replace with your logo asset path
                      height: 80,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.engineering,
                        size: 60,
                        color: AppColors.primaryRed,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Maintenance Engineer Login",
                      style: LoginStyles.titleText,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _employeeIdController,
                      decoration: LoginStyles.inputDecoration("Employee ID", Icons.badge),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: LoginStyles.inputDecoration(
                        "Password",
                        Icons.lock,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.darkRedText.withOpacity(0.6),
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _isLoading
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryRed),
                    )
                        : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _attemptLogin,
                        icon: const Icon(Icons.login, size: 20),
                        label: const Text("Login"),
                        style: LoginStyles.loginButtonStyle,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_feedbackMessage.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            _feedbackIcon ?? Icons.info,
                            color: AppColors.primaryRed,
                            size: 20,
                          ),
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
          ),
        ),
      ),
    );
  }
}