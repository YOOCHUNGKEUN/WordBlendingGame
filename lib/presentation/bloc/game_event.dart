// lib/presentation/bloc/game_event.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/canvas_word.dart';
import '../../domain/entities/word.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class GameInitialized extends GameEvent {
  const GameInitialized();
}

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

/// 팔레트에서 캔버스로 드래그 후 즉시 합성 시도
class WordDroppedFromPalette extends GameEvent {
  final Word word;
  final double x;
  final double y;

  const WordDroppedFromPalette({
    required this.word,
    required this.x,
    required this.y,
  });

  @override
  List<Object?> get props => [word, x, y];
}

class CanvasWordDeleted extends GameEvent {
  final String canvasId;

  const CanvasWordDeleted({required this.canvasId});

  @override
  List<Object?> get props => [canvasId];
}

class CombinationResultDismissed extends GameEvent {
  const CombinationResultDismissed();
}

class CanvasCleared extends GameEvent {
  const CanvasCleared();
}

class RecipeBookOpened extends GameEvent {
  const RecipeBookOpened();
}

class HintRequested extends GameEvent {
  const HintRequested();
}

class HintDismissed extends GameEvent {
  const HintDismissed();
}