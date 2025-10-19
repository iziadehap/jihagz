import 'package:flutter/material.dart';

class AppCore {
  final Color primaryColor = Color(0xFF1E88E5); // أزرق رياضي
  final Color secondaryColor = Color(0xFFc2fa61); // أصفر طاقة
  final Color backgroundColor = Color(0xFF121212); // خلفية داكنة
  final Color surfaceColor = Color(0xFF1F1F1F); // كروت وأزرار
  final Color warningColor = Color(0xFFFFC107); // Amber
  final Color successColor = Color(0xFF4CAF50); // Green
  final Color textColor = Colors
      .white; // Default to white for dark mode, override in light mode if needed

  static const String googleWebClientId =
      '955036418853-3p9m14jnp1j09tco8casbupojdvpbhud.apps.googleusercontent.com';

  static const String googleIOSClientId =
      '955036418853-hsmcgae5vdv60496b2eie2quo7d0je0r.apps.googleusercontent.com'; // استبدل هذا بمعرف العميل الخاص بـ iOS

  static const List<String> sportTypes = [
    'Football',
    'Padel',
    'Tennis',
    'Custom',
  ];
  // Add other configuration constants here
  static const String appName = 'Jihagz';
  static const String appVersion = '1.0.0';
}
