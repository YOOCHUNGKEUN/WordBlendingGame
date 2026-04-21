// lib/presentation/widgets/hint_popup.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/datasources/word_data/word_data_registry.dart';
import '../../domain/entities/word_combination.dart';

void showHintPopup(
    BuildContext context,
    WordCombination hint, {
      required VoidCallback onDismiss, // ✅ 닫기 콜백 추가
    }) {
  final w1Info = _findWordInfo(hint.word1Id);
  final w2Info = _findWordInfo(hint.word2Id);

  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 배지
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade400, Colors.orange.shade400],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '💡 이런 조합은 어때요?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ✅ 합성 수식 - 오버플로우 수정
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: _ingredientChip(w1Info['emoji']!, w1Info['text']!)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                Flexible(child: _ingredientChip(w2Info['emoji']!, w2Info['text']!)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '=',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                // 결과는 ? 로 숨김
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '?',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 안내 문구
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '이 두 단어를 캔버스에서 합쳐보세요!\n무엇이 될까요? 🤔',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // 확인 버튼
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(ctx);  // ✅ 팝업 먼저 닫고
                  onDismiss();         // ✅ 그 다음 HintDismissed 호출
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber.shade400,
                        Colors.orange.shade400,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    '도전해볼게요! 🔥',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _ingredientChip(String emoji, String text) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(emoji, style: const TextStyle(fontSize: 28)),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ],
  );
}

Map<String, String> _findWordInfo(String id) {
  for (final w in WordDataRegistry.baseWords) {
    if (w['id'] == id) {
      return {'text': w['text'] as String, 'emoji': w['emoji'] as String};
    }
  }
  for (final combo in WordDataRegistry.combinations) {
    final result = combo['result'] as Map<String, dynamic>;
    if (result['id'] == id) {
      return {
        'text': result['text'] as String,
        'emoji': result['emoji'] as String,
      };
    }
  }
  return {'text': id, 'emoji': '❓'};
}