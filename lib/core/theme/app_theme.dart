// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  // 색상
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFFEDE9FF);
  static const Color secondary = Color(0xFFFF6584);
  static const Color accent = Color(0xFFFFD700);
  static const Color success = Color(0xFF43D975);
  static const Color background = Color(0xFFF8F7FF);
  static const Color canvasBackground = Color(0xFFF0EEF9);
  static const Color cardColor = Colors.white;
  static const Color textDark = Color(0xFF2D2D44);
  static const Color textLight = Color(0xFF8A8A9E);

  // 단어 카테고리 색상
  static const Map<String, Color> categoryColors = {
    'nature': Color(0xFFB5EAD7),
    'animal': Color(0xFFFFDAC1),
    'food': Color(0xFFFF9AA2),
    'weather': Color(0xFFC7CEEA),
    'body': Color(0xFFFFE4E1),
    'object': Color(0xFFE2F0CB),
    'compound': Color(0xFFFFF1CC),
  };

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        background: background,
      ),
      scaffoldBackgroundColor: background,
      fontFamily: 'NotoSansKR',
      useMaterial3: true,
    );
  }
}

// lib/core/constants/app_constants.dart
class AppConstants {
  static const double wordCardWidth = 100.0;
  static const double wordCardHeight = 52.0;
  static const double paletteHeight = 180.0;
  static const double canvasSize = 2000.0; // 스크롤 가능한 무한 캔버스 크기
  static const double snapDistance = 80.0;
  static const double wordFontSize = 15.0;
  static const double emojiFontSize = 22.0;
}
