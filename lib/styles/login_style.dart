import 'package:flutter/material.dart';
import 'app_colors.dart';

class LoginStyles {
  // Login card container decoration
  static const TextStyle titleText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.darkRedText, // ensure this is const in app_colors.dart too
  );

  static final BoxDecoration cardBox = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 6),
      ),
    ],
  );

  // Role selection button (Customer, Vendor, Employee)
  static ButtonStyle roleButton(bool isActive) => ElevatedButton.styleFrom(
    backgroundColor:
    isActive ? AppColors.roleTabActive : AppColors.white,
    foregroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: isActive ? AppColors.primaryRed : AppColors.borderGrey,
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 14),
    elevation: 0,
  );

  // Login button style
  static final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryRed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14),
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  );

  // Input field decoration
  static InputDecoration inputDecoration(String label, IconData icon, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.inputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // Heading text (e.g., "Welcome to ERP Portal")
  static const TextStyle headingText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.darkRedText,
  );

  // Error message style
  static const TextStyle errorText = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w600,
  );
}
