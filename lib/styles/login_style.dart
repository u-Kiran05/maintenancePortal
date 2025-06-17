import 'package:flutter/material.dart';
import 'app_colors.dart';

class LoginStyles {
  // Login card container decoration with glassmorphism effect
  static final BoxDecoration cardBox = BoxDecoration(
    color: AppColors.white.withOpacity(0.95),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: AppColors.white.withOpacity(0.3),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: Offset(0, 8),
      ),
    ],
    gradient: LinearGradient(
      colors: [
        AppColors.white.withOpacity(0.9),
        AppColors.white.withOpacity(0.7),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  // Title text style
  static const TextStyle titleText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.darkRedText,
    letterSpacing: 0.5,
  );

  // Role selection button (Customer, Vendor, Employee)
  static ButtonStyle roleButton(bool isActive) => ElevatedButton.styleFrom(
    backgroundColor: isActive
        ? AppColors.primaryRed.withOpacity(0.1)
        : AppColors.white.withOpacity(0.8),
    foregroundColor: AppColors.darkRedText,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: isActive ? AppColors.primaryRed : AppColors.borderGrey.withOpacity(0.5),
        width: 1.5,
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    elevation: isActive ? 2 : 0,
    shadowColor: AppColors.primaryRed.withOpacity(0.3),
  );

  // Login button style with hover effect
  static final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryRed,
    foregroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(vertical: 16),
    textStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    elevation: 3,
    shadowColor: AppColors.primaryRed.withOpacity(0.4),
  );

  // Input field decoration with modern styling
  static InputDecoration inputDecoration(String label, IconData icon, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: AppColors.darkRedText.withOpacity(0.7),
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(icon, color: AppColors.primaryRed),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.inputFill.withOpacity(0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.borderGrey.withOpacity(0.3),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.primaryRed,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }

  // Heading text (e.g., "Welcome to ERP Portal")
  static const TextStyle headingText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.darkRedText,
    letterSpacing: 0.5,
  );

  // Error message style with subtle gradient
  static const TextStyle errorText = TextStyle(
    color: AppColors.primaryRed,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
}