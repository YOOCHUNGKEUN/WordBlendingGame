// lib/presentation/pages/recipe_book_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/word.dart';
import '../../domain/entities/word_combination.dart';
import '../../core/theme/app_theme.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_state.dart';
import '../widgets/combination_result_popup.dart';
import '../../data/datasources/word_data/word_data_registry.dart';

class RecipeBookPage extends StatelessWidget {
  const RecipeBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final discovered = state.discoveredWords;
        final total = state.paletteWords.length + discovered.length;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: AppColors.textDark,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              '📖 내 단어 도감',
              style: TextStyle(
                color: AppColors.textDark,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              _ProgressBanner(discovered: discovered.length, total: total),
              const SizedBox(height: 8),
              Expanded(
                child: discovered.isEmpty ? _EmptyState() : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: discovered.length,
                  itemBuilder: (context, index) =>
                      _WordTile(word: discovered[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── 타일 ──────────────────────────────────────────────────
class _WordTile extends StatelessWidget {
  final Word word;
  const _WordTile({required this.word});

  Color get _bgColor => AppTheme.categoryColors[word.category.name] ?? AppColors.primaryLight;

  WordCombination? _findRecipe() {
    for (final combo in WordDataRegistry.combinations) {
      final resultMap = combo['result'] as Map<String, dynamic>;
      if (resultMap['id'] == word.id) {
        return WordCombination(
          word1Id: combo['w1'] as String,
          word2Id: combo['w2'] as String,
          result: word,
          description: combo['desc'] as String,
        );
      }
    }
    return null;
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final recipe = _findRecipe();

        if (recipe != null) {
          // 합성 단어 → 공용 다이얼로그
          showWordCombinationDialog(
            context: context,
            combination: recipe,
            word1Info: _findWordInfo(recipe.word1Id),
            word2Info: _findWordInfo(recipe.word2Id),
          );
        } else {
          // 기본 단어 → 간단 안내
          showWordCombinationDialog(
            context: context,
            combination: WordCombination(
              word1Id: '',
              word2Id: '',
              result: word,
              description: '기본 단어예요! 다른 단어와 합쳐보세요. ✨',
            ),
            badgeText: '⭐ 기본 단어',
            confirmLabel: '알겠어요!',
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: _bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(word.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 6),
            Text(
              word.text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            if (word.level > 1)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '⭐' * word.level,
                  style: const TextStyle(fontSize: 9),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── 진행 배너 ─────────────────────────────────────────────
class _ProgressBanner extends StatelessWidget {
  final int discovered;
  final int total;
  const _ProgressBanner({required this.discovered, required this.total});

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : discovered / total;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, const Color(0xFF9B93FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$discovered개 발견했어요! 🌟',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '전체 $total개 중',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '${(progress * 100).round()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// ── 빈 상태 ───────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            '아직 합성 단어가 없어요!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '단어 카드를 서로 합쳐보세요 ✨',
            style: TextStyle(fontSize: 13, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }
}