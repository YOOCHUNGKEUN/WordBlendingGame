// lib/presentation/widgets/combination_result_popup.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/word_combination.dart';
import '../../core/theme/app_theme.dart';

/// 캔버스 합성 시 전체화면 팝업
class CombinationResultPopup extends StatefulWidget {
  final WordCombination combination;
  final VoidCallback onDismiss;
  final Map<String, String>? word1Info;
  final Map<String, String>? word2Info;

  const CombinationResultPopup({
    super.key,
    required this.combination,
    required this.onDismiss,
    this.word1Info,
    this.word2Info,
  });

  @override
  State<CombinationResultPopup> createState() =>
      _CombinationResultPopupState();
}

class _CombinationResultPopupState extends State<CombinationResultPopup>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _floatController;
  late Animation<double> _scaleAnim;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _scaleAnim =
        CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut);
    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDismiss,
      child: Container(
        color: Colors.black.withOpacity(0.45),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnim,
            child: AnimatedBuilder(
              animation: _floatAnim,
              builder: (context, child) => Transform.translate(
                offset: Offset(0, _floatAnim.value),
                child: child,
              ),
              child: WordCombinationCard(
                combination: widget.combination,
                badgeText: '🎉 새 단어 발견!',
                confirmLabel: '와! 신기해요! 🙌',
                word1Info: widget.word1Info,
                word2Info: widget.word2Info,
                onConfirm: widget.onDismiss,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
/// 공용 카드 위젯
// ─────────────────────────────────────────────────────────
class WordCombinationCard extends StatelessWidget {
  final WordCombination combination;
  final String badgeText;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final Map<String, String>? word1Info;
  final Map<String, String>? word2Info;

  const WordCombinationCard({
    super.key,
    required this.combination,
    required this.badgeText,
    required this.confirmLabel,
    required this.onConfirm,
    this.word1Info,
    this.word2Info,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      // margin을 화면 비율로 계산해서 넘침 방지
      width: screenWidth * 0.82,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 40,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 배지
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 합성 수식 - IntrinsicWidth 대신 Row를 명시적 너비 안에서 처리
          _buildFormulaRow(),
          const SizedBox(height: 16),

          // 결과 단어
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
              border:
              Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(combination.result.emoji,
                    style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    combination.result.text,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 교육 설명
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💡', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    combination.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textDark,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 확인 버튼
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: onConfirm,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, const Color(0xFF9B93FF)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  confirmLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
    );
  }

  Widget _buildFormulaRow() {
    final w1Emoji = word1Info?['emoji'] ?? '❓';
    final w1Text = word1Info?['text'] ?? combination.word1Id;
    final w2Emoji = word2Info?['emoji'] ?? '❓';
    final w2Text = word2Info?['text'] ?? combination.word2Id;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 재료1
        Flexible(child: _ingredientChip(w1Emoji, w1Text)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              color: AppColors.textLight,
            ),
          ),
        ),
        // 재료2
        Flexible(child: _ingredientChip(w2Emoji, w2Text)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            '=',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              color: AppColors.textLight,
            ),
          ),
        ),
        // 결과 미리보기 (작게)
        Flexible(
          child: _ingredientChip(
            combination.result.emoji,
            combination.result.text,
          ),
        ),
      ],
    );
  }

  Widget _ingredientChip(String emoji, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
/// 도감 등 어디서든 호출 가능한 헬퍼
// ─────────────────────────────────────────────────────────
void showWordCombinationDialog({
  required BuildContext context,
  required WordCombination combination,
  Map<String, String>? word1Info,
  Map<String, String>? word2Info,
  String badgeText = '📖 단어 정보',
  String confirmLabel = '확인 ✨',
}) {
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28)),
      // insetPadding으로 다이얼로그 자체 여백 제어
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: WordCombinationCard(
        combination: combination,
        badgeText: badgeText,
        confirmLabel: confirmLabel,
        word1Info: word1Info,
        word2Info: word2Info,
        onConfirm: () => Navigator.pop(ctx),
      ),
    ),
  );
}