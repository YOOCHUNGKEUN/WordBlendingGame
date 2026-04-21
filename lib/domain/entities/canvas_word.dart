// lib/domain/entities/canvas_word.dart

import 'package:equatable/equatable.dart';
import 'word.dart';

class CanvasWord extends Equatable {
  final String canvasId; // 캔버스에서의 고유 ID (같은 단어도 여러 개 배치 가능)
  final Word word;
  final double x;
  final double y;
  final bool isAnimating; // 합성 애니메이션 중인지

  const CanvasWord({
    required this.canvasId,
    required this.word,
    required this.x,
    required this.y,
    this.isAnimating = false,
  });

  CanvasWord copyWith({
    String? canvasId,
    Word? word,
    double? x,
    double? y,
    bool? isAnimating,
  }) {
    return CanvasWord(
      canvasId: canvasId ?? this.canvasId,
      word: word ?? this.word,
      x: x ?? this.x,
      y: y ?? this.y,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }

  @override
  List<Object?> get props => [canvasId, word, x, y, isAnimating];
}
