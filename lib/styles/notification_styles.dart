import 'package:flutter/material.dart';
import 'app_colors.dart';

class NotificationStyles {
  static const EdgeInsets cardMargin = EdgeInsets.only(bottom: 12);
  static const EdgeInsets cardPadding = EdgeInsets.all(12);
  static final ShapeBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  );

  static const TextStyle titleText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.darkRedText,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );

  static const TextStyle metaText = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );
}
