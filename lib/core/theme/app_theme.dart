import 'package:flutter/material.dart';
import 'package:word_alchemy_new/core/constants/app_colors.dart';

class AppTheme {

  // 단어 카테고리 색상
  static const Map<String, Color> categoryColors = {
    'nature': Color(0xFFB7EF63),
    'animal': Color(0xFFFFD95B),
    'food': Color(0xFFFF8AB5),
    'weather': Color(0xFF8ED8FF),
    'body': Color(0xFFFFB66E),
    'object': Color(0xFF7AD7FF),
    'compound': Color(0xFFFFF176),
  };

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        surface: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'NotoSansKR',
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.textDark,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}


