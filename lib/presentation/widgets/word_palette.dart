// lib/presentation/widgets/word_palette.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/word.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_state.dart';
import 'word_card.dart';
import '../../core/theme/app_theme.dart';

class WordPalette extends StatefulWidget {
  const WordPalette({super.key});

  @override
  State<WordPalette> createState() => _WordPaletteState();
}

class _WordPaletteState extends State<WordPalette> {
  final ScrollController _scrollController = ScrollController();
  double _scrollFraction = 0.0;
  final int wordline = 3;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      final max = _scrollController.position.maxScrollExtent;
      if (max <= 0) return;
      setState(() {
        _scrollFraction = _scrollController.offset / max;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.12),
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
                margin: const EdgeInsets.only(top: 10, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // 헤더
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                  children: [
                    const Text('✨ 단어 카드', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF8A8A9E))),
                    const Text('(꾹 눌러 카드를 이동하세요)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF8A8A9E))),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${state.discoveredWords.length}개 발견!',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 단어 2줄 그리드 (가로 스크롤)
              SizedBox(
                height: 200,
                child: ScrollConfiguration(
                  behavior: _NoOverscrollBehavior(),
                  child: ListView.separated(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: (state.paletteWords.length / wordline).ceil(),
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, colIndex) {
                      final firstIdx = colIndex * 3;   // 2 → 3
                      final secondIdx = firstIdx + 1;
                      final thirdIdx = firstIdx + 2;   // 추가
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _DraggablePaletteWord(word: state.paletteWords[firstIdx]),
                          if (secondIdx < state.paletteWords.length) ...[
                            const SizedBox(height: 8),
                            _DraggablePaletteWord(word: state.paletteWords[secondIdx]),
                          ],
                          if (thirdIdx < state.paletteWords.length) ...[  // 추가
                            const SizedBox(height: 8),
                            _DraggablePaletteWord(word: state.paletteWords[thirdIdx]),
                          ],
                        ],
                      );
                    },                  ),
                ),
              ),
              const SizedBox(height: 8),
              // 스크롤 인디케이터 바
              _ScrollIndicatorBar(
                scrollFraction: _scrollFraction,
                itemCount: state.paletteWords.length,
              ),
              SizedBox(height: bottomInset > 0 ? bottomInset : 12),
            ],
          ),
        );
      },
    );
  }
}

class _ScrollIndicatorBar extends StatelessWidget {
  final double scrollFraction;
  final int itemCount;
  final int wordline = 3;


  const _ScrollIndicatorBar({
    required this.scrollFraction,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final visibleCols = (screenWidth / 116).floor();
    final totalCols = (itemCount / wordline).ceil();
    if (totalCols <= visibleCols) return const SizedBox.shrink();
    final trackWidth = screenWidth * 0.5;
    final thumbWidth = (visibleCols / totalCols) * trackWidth;
    final thumbOffset = scrollFraction * (trackWidth - thumbWidth);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SizedBox(
        width: trackWidth,
        height: 4,
        child: Stack(
          children: [
            Positioned(
              left: thumbOffset,
              child: Container(
                width: thumbWidth,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _DraggablePaletteWord extends StatelessWidget {
  final Word word;

  const _DraggablePaletteWord({required this.word});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Word>(
      data: word,
      delay: const Duration(milliseconds: 150),
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
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: WordCard(word: word),
      ),
      child: WordCard(word: word),
    );
  }
}