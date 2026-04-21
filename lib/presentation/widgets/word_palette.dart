// lib/presentation/widgets/word_palette.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/word.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_state.dart';
import 'word_card.dart';
import '../../core/theme/app_theme.dart';

class WordPalette extends StatelessWidget {
  const WordPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 드래그 핸들
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 6),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // 제목
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      '✨ 단어 카드',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textLight,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${state.discoveredWords.length}개 발견!',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 단어 목록 (가로 스크롤)
              SizedBox(
                height: 70,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  itemCount: state.paletteWords.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final word = state.paletteWords[index];
                    return _DraggablePaletteWord(word: word);
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _DraggablePaletteWord extends StatelessWidget {
  final Word word;

  const _DraggablePaletteWord({required this.word});

  @override
  Widget build(BuildContext context) {
    return Draggable<Word>(
      data: word,
      // 드래그 중 보여줄 위젯
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.85,
          child: WordCard(
            word: word,
            width: 108,
            height: 52,
            isOnCanvas: true,
          ),
        ),
      ),
      // 드래그 중 원래 자리
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: WordCard(word: word),
      ),
      child: WordCard(word: word),
    );
  }
}
