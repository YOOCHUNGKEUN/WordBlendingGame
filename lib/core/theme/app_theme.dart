import 'package:flutter/material.dart';
import 'package:word_alchemy_new/core/constants/app_colors.dart';

class AppTheme {

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
        seedColor: AppColors.primary,
        background: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'NotoSansKR',
      useMaterial3: true,
    );
  }
}


