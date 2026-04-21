// lib/presentation/bloc/game_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/canvas_word.dart';
import '../../domain/entities/word.dart';
import '../../domain/entities/word_combination.dart';

enum GameStatus { initial, loading, ready, combining, error }

class GameState extends Equatable {
  final GameStatus status;
  final List<Word> paletteWords;        // 하단 팔레트 단어들
  final List<CanvasWord> canvasWords;   // 캔버스에 놓인 단어들
  final List<Word> discoveredWords;     // 발견한 단어 목록 (도감)
  final WordCombination? lastCombination; // 최근 합성 결과
  final bool showCombinationResult;     // 합성 결과 팝업 표시 여부
  final String? errorMessage;

  const GameState({
    this.status = GameStatus.initial,
    this.paletteWords = const [],
    this.canvasWords = const [],
    this.discoveredWords = const [],
    this.lastCombination,
    this.showCombinationResult = false,
    this.errorMessage,
  });

  GameState copyWith({
    GameStatus? status,
    List<Word>? paletteWords,
    List<CanvasWord>? canvasWords,
    List<Word>? discoveredWords,
    WordCombination? lastCombination,
    bool? showCombinationResult,
    String? errorMessage,
    bool clearLastCombination = false,
  }) {
    return GameState(
      status: status ?? this.status,
      paletteWords: paletteWords ?? this.paletteWords,
      canvasWords: canvasWords ?? this.canvasWords,
      discoveredWords: discoveredWords ?? this.discoveredWords,
      lastCombination: clearLastCombination ? null : (lastCombination ?? this.lastCombination),
      showCombinationResult: showCombinationResult ?? this.showCombinationResult,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        paletteWords,
        canvasWords,
        discoveredWords,
        lastCombination,
        showCombinationResult,
        errorMessage,
      ];
}
