import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Base
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color surfaceLight = Color(0xFF2A2A2A);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A0A0);

  // Brand Core
  static const Color primary = Color(0xFF00FFC2); // Lime Green / Electric Cyan mix equivalent to Electric Blue/Lime Green prompt
  static const Color primaryBlue = Color(0xFF0052FF); // Electric Blue
  static const Color secondaryGreen = Color(0xFF39FF14); // Lime Green
  
  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFC107);
  
  // Utility
  static const Color divider = Color(0xFF333333);
  static const Color cardShadow = Color(0x33000000);
  static const Color transparent = Color.fromARGB(0, 0, 0, 0);
}
