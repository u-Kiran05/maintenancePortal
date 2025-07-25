// styles/workorder_styles.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
class WorkOrderStyles {
  static const cardMargin = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  static const cardElevation = 3.0;

  static const titleTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.darkRedText,
  );

  static const subtitleTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );
}
