// lib/presentation/bloc/game_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/canvas_word.dart';
import '../../domain/entities/word.dart';
import '../../domain/entities/word_combination.dart';

enum GameStatus { initial, loading, ready, combining, error }

class GameState extends Equatable {
  final GameStatus status;
  final List<Word> paletteWords;
  final List<CanvasWord> canvasWords;
  final List<Word> discoveredWords;
  final WordCombination? lastCombination;
  final bool showCombinationResult;
  final String? errorMessage;
  final WordCombination? hintCombination; // ← 추가

  const GameState({
    this.status = GameStatus.initial,
    this.paletteWords = const [],
    this.canvasWords = const [],
    this.discoveredWords = const [],
    this.lastCombination,
    this.showCombinationResult = false,
    this.errorMessage,
    this.hintCombination, // ← 추가
  });

  GameState copyWith({
    GameStatus? status,
    List<Word>? paletteWords,
    List<CanvasWord>? canvasWords,
    List<Word>? discoveredWords,
    WordCombination? lastCombination,
    bool? showCombinationResult,
    String? errorMessage,
    WordCombination? hintCombination,  // ← 추가
    bool clearLastCombination = false,
    bool clearHint = false,            // ← 추가
  }) {
    return GameState(
      status: status ?? this.status,
      paletteWords: paletteWords ?? this.paletteWords,
      canvasWords: canvasWords ?? this.canvasWords,
      discoveredWords: discoveredWords ?? this.discoveredWords,
      lastCombination: clearLastCombination ? null : (lastCombination ?? this.lastCombination),
      showCombinationResult: showCombinationResult ?? this.showCombinationResult,
      errorMessage: errorMessage ?? this.errorMessage,
      hintCombination: clearHint ? null : (hintCombination ?? this.hintCombination), // ← 추가
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
    hintCombination, // ← 추가
  ];
}
