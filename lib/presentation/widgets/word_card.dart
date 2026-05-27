// lib/presentation/widgets/word_card.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/word.dart';
import '../../core/theme/app_theme.dart';

class WordCard extends StatelessWidget {
  final Word word;
  final double? width;
  final double? height;
  final bool isOnCanvas;
  final VoidCallback? onDoubleTap;

  const WordCard({
    super.key,
    required this.word,
    this.width,
    this.height,
    this.isOnCanvas = false,
    this.onDoubleTap,
  });

  Color get _bgColor {
    final categoryName = word.category.name;
    return AppTheme.categoryColors[categoryName] ?? AppColors.primaryLight;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width ?? 100,
        height: height ?? 52,
        decoration: BoxDecoration(
          color: _bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isOnCanvas
                ? AppColors.titleBlue
                : Colors.white,
            width: isOnCanvas ? 2.5 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.titleBlue.withOpacity(0.16),
              blurRadius: isOnCanvas ? 10 : 7,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.75),
              blurRadius: 0,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              word.emoji,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                word.text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
