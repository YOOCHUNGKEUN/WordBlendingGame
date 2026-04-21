// lib/presentation/bloc/game_event.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/canvas_word.dart';
import '../../domain/entities/word.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

/// 게임 초기화
class GameInitialized extends GameEvent {
  const GameInitialized();
}

/// 하단 팔레트에서 캔버스로 단어 드래그해서 배치
class WordPlacedOnCanvas extends GameEvent {
  final Word word;
  final double x;
  final double y;

  const WordPlacedOnCanvas({
    required this.word,
    required this.x,
    required this.y,
  });

  @override
  List<Object?> get props => [word, x, y];
}

/// 캔버스 위의 단어를 다른 위치로 이동
class CanvasWordMoved extends GameEvent {
  final String canvasId;
  final double x;
  final double y;

  const CanvasWordMoved({
    required this.canvasId,
    required this.x,
    required this.y,
  });

  @override
  List<Object?> get props => [canvasId, x, y];
}

/// 드래그 종료 시 가까운 단어와 합성 시도
class WordDropped extends GameEvent {
  final String draggedCanvasId;
  final double dropX;
  final double dropY;

  const WordDropped({
    required this.draggedCanvasId,
    required this.dropX,
    required this.dropY,
  });

  @override
  List<Object?> get props => [draggedCanvasId, dropX, dropY];
}

/// 캔버스에서 단어 삭제
class CanvasWordDeleted extends GameEvent {
  final String canvasId;

  const CanvasWordDeleted({required this.canvasId});

  @override
  List<Object?> get props => [canvasId];
}

/// 합성 결과 팝업 닫기
class CombinationResultDismissed extends GameEvent {
  const CombinationResultDismissed();
}

/// 전체 캔버스 초기화
class CanvasCleared extends GameEvent {
  const CanvasCleared();
}

/// 도감 보기
class RecipeBookOpened extends GameEvent {
  const RecipeBookOpened();
}
