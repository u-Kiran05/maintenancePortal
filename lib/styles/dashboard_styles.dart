import 'package:flutter/material.dart';
import 'app_colors.dart'; // Make sure to import your color constants

class DashboardStyles {
  static const EdgeInsets gridPadding = EdgeInsets.all(16.0);

  static const cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static const double iconSize = 48;

  static const cardTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.darkRedText,
  );

  static const cardBackgroundColor = AppColors.roleTabActive;
  static const cardIconColor = AppColors.primaryRed;
}
