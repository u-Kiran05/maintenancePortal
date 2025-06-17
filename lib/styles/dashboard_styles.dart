import 'package:flutter/material.dart';
import 'app_colors.dart';

class DashboardStyles {
  // Card padding and margin for consistent spacing
  static const cardPadding = EdgeInsets.all(20);
  static const cardMargin = EdgeInsets.symmetric(horizontal: 16, vertical: 10);

  // Card border radius for rounded corners
  static const cardBorderRadius = BorderRadius.all(Radius.circular(16));

  // Card decoration with glassmorphism effect
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.white.withOpacity(0.95),
    borderRadius: cardBorderRadius,
    border: Border.all(
      color: AppColors.white.withOpacity(0.3),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryRed.withOpacity(0.15),
        blurRadius: 12,
        offset: const Offset(0, 4),
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

  // Section title style for headers
  static const sectionTitleTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.darkRedText,
    letterSpacing: 0.5,
  );

  // Card title style for individual cards
  static const cardTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkRedText,
    letterSpacing: 0.3,
  );

  // Card subtitle style for secondary text
  static const cardSubTitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkRedText,
  );

  // Navigation bar label style
  static const navBarLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryRed,
  );

  // Navigation bar unselected label style
  static final navBarUnselectedLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.darkRedText.withOpacity(0.6),
  );
}