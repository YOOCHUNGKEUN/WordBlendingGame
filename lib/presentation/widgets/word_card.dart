// lib/presentation/widgets/word_card.dart

import 'package:flutter/material.dart';
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
    return AppTheme.categoryColors[categoryName] ?? AppTheme.primaryLight;
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
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isOnCanvas
                ? AppTheme.primary.withOpacity(0.4)
                : Colors.white,
            width: isOnCanvas ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: isOnCanvas ? 8 : 4,
              offset: const Offset(0, 2),
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
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
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
