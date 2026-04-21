// lib/presentation/bloc/game_bloc.dart

import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/canvas_word.dart';
import '../../domain/entities/word.dart';
import '../../domain/usecases/combine_words_usecase.dart';
import '../../domain/usecases/get_base_words_usecase.dart';
import '../../domain/usecases/save_discovered_word_usecase.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetBaseWordsUseCase getBaseWordsUseCase;
  final CombineWordsUseCase combineWordsUseCase;
  final SaveDiscoveredWordUseCase saveDiscoveredWordUseCase;

  static const double _snapDistance = 80.0; // 이 거리 이내면 합성 시도

  GameBloc({
    required this.getBaseWordsUseCase,
    required this.combineWordsUseCase,
    required this.saveDiscoveredWordUseCase,
  }) : super(const GameState()) {
    on<GameInitialized>(_onGameInitialized);
    on<WordPlacedOnCanvas>(_onWordPlacedOnCanvas);
    on<CanvasWordMoved>(_onCanvasWordMoved);
    on<WordDropped>(_onWordDropped);
    on<CanvasWordDeleted>(_onCanvasWordDeleted);
    on<CombinationResultDismissed>(_onCombinationResultDismissed);
    on<CanvasCleared>(_onCanvasCleared);
  }

  Future<void> _onGameInitialized(
      GameInitialized event, Emitter<GameState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    final result = await getBaseWordsUseCase();
    result.fold(
      (error) => emit(state.copyWith(
          status: GameStatus.error, errorMessage: error)),
      (words) => emit(state.copyWith(
          status: GameStatus.ready, paletteWords: words)),
    );
  }

  void _onWordPlacedOnCanvas(
      WordPlacedOnCanvas event, Emitter<GameState> emit) {
    final canvasWord = CanvasWord(
      canvasId: _generateCanvasId(),
      word: event.word,
      x: event.x,
      y: event.y,
    );
    final updated = List<CanvasWord>.from(state.canvasWords)..add(canvasWord);
    emit(state.copyWith(canvasWords: updated));
  }

  void _onCanvasWordMoved(CanvasWordMoved event, Emitter<GameState> emit) {
    final updated = state.canvasWords.map((cw) {
      if (cw.canvasId == event.canvasId) {
        return cw.copyWith(x: event.x, y: event.y);
      }
      return cw;
    }).toList();
    emit(state.copyWith(canvasWords: updated));
  }

  Future<void> _onWordDropped(
      WordDropped event, Emitter<GameState> emit) async {
    final dragged = state.canvasWords
        .where((cw) => cw.canvasId == event.draggedCanvasId)
        .firstOrNull;
    if (dragged == null) return;

    // 가장 가까운 다른 단어 찾기
    CanvasWord? nearest;
    double nearestDist = _snapDistance;

    for (final other in state.canvasWords) {
      if (other.canvasId == event.draggedCanvasId) continue;
      final dist = _distance(event.dropX, event.dropY, other.x, other.y);
      if (dist < nearestDist) {
        nearestDist = dist;
        nearest = other;
      }
    }

    if (nearest == null) return; // 합성 대상 없음

    // 합성 시도
    emit(state.copyWith(status: GameStatus.combining));

    final result = await combineWordsUseCase(CombineWordsParams(
      word1Id: dragged.word.id,
      word2Id: nearest.word.id,
    ));

    await result.fold(
      (error) async {
        emit(state.copyWith(status: GameStatus.ready));
      },
      (combination) async {
        if (combination == null) {
          // 합성 안 됨 - 그냥 위치만 업데이트
          emit(state.copyWith(status: GameStatus.ready));
          return;
        }

        // 합성 성공! 두 단어를 제거하고 결과 단어 추가
        final midX = (dragged.x + nearest!.x) / 2;
        final midY = (dragged.y + nearest.y) / 2;

        final newCanvasWord = CanvasWord(
          canvasId: _generateCanvasId(),
          word: combination.result,
          x: midX,
          y: midY,
        );

        final updatedCanvas = state.canvasWords
            .where((cw) =>
                cw.canvasId != dragged.canvasId &&
                cw.canvasId != nearest!.canvasId)
            .toList()
          ..add(newCanvasWord);

        // 새로 발견한 단어인지 확인
        final isNewDiscovery = !state.discoveredWords
            .any((w) => w.id == combination.result.id);

        List<Word> updatedDiscovered = List.from(state.discoveredWords);
        if (isNewDiscovery) {
          updatedDiscovered.add(combination.result);
          await saveDiscoveredWordUseCase(combination.result);

          // 발견한 단어면 팔레트에도 추가
          final alreadyInPalette =
              state.paletteWords.any((w) => w.id == combination.result.id);
          if (!alreadyInPalette) {
            final updatedPalette = List<Word>.from(state.paletteWords)
              ..add(combination.result);
            emit(state.copyWith(
              status: GameStatus.ready,
              canvasWords: updatedCanvas,
              paletteWords: updatedPalette,
              discoveredWords: updatedDiscovered,
              lastCombination: combination,
              showCombinationResult: true,
            ));
            return;
          }
        }

        emit(state.copyWith(
          status: GameStatus.ready,
          canvasWords: updatedCanvas,
          discoveredWords: updatedDiscovered,
          lastCombination: combination,
          showCombinationResult: isNewDiscovery,
        ));
      },
    );
  }

  void _onCanvasWordDeleted(
      CanvasWordDeleted event, Emitter<GameState> emit) {
    final updated =
        state.canvasWords.where((cw) => cw.canvasId != event.canvasId).toList();
    emit(state.copyWith(canvasWords: updated));
  }

  void _onCombinationResultDismissed(
      CombinationResultDismissed event, Emitter<GameState> emit) {
    emit(state.copyWith(
      showCombinationResult: false,
      clearLastCombination: true,
    ));
  }

  void _onCanvasCleared(CanvasCleared event, Emitter<GameState> emit) {
    emit(state.copyWith(canvasWords: []));
  }

  double _distance(double x1, double y1, double x2, double y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }

  String _generateCanvasId() {
    return DateTime.now().microsecondsSinceEpoch.toString() +
        Random().nextInt(9999).toString();
  }
}
