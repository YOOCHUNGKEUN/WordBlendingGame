// lib/presentation/bloc/game_bloc.dart

import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/word_data/word_data_registry.dart';
import '../../domain/entities/canvas_word.dart';
import '../../domain/entities/word.dart';
import '../../domain/entities/word_combination.dart';
import '../../domain/usecases/combine_words_usecase.dart';
import '../../domain/usecases/get_base_words_usecase.dart';
import '../../domain/usecases/get_canvas_words_usecase.dart';
import '../../domain/usecases/get_discovered_words_usecase.dart';
import '../../domain/usecases/save_canvas_words_usecase.dart';
import '../../domain/usecases/save_discovered_word_usecase.dart';
import 'game_event.dart';
import 'game_state.dart';

const double _cardW = 108.0;
const double _cardH = 52.0;

class GameBloc extends Bloc<GameEvent, GameState> {
  final GetBaseWordsUseCase getBaseWordsUseCase;
  final CombineWordsUseCase combineWordsUseCase;
  final SaveDiscoveredWordUseCase saveDiscoveredWordUseCase;
  final GetDiscoveredWordsUseCase getDiscoveredWordsUseCase;
  final GetCanvasWordsUseCase getCanvasWordsUseCase;
  final SaveCanvasWordsUseCase saveCanvasWordsUseCase;

  GameBloc({
    required this.getBaseWordsUseCase,
    required this.combineWordsUseCase,
    required this.saveDiscoveredWordUseCase,
    required this.getDiscoveredWordsUseCase,
    required this.getCanvasWordsUseCase,
    required this.saveCanvasWordsUseCase,
  }) : super(const GameState()) {
    on<GameInitialized>(_onGameInitialized);
    on<WordPlacedOnCanvas>(_onWordPlacedOnCanvas);
    on<CanvasWordMoved>(_onCanvasWordMoved);
    on<WordDropped>(_onWordDropped);
    on<WordDroppedFromPalette>(_onWordDroppedFromPalette);
    on<CanvasWordDeleted>(_onCanvasWordDeleted);
    on<CombinationResultDismissed>(_onCombinationResultDismissed);
    on<CanvasCleared>(_onCanvasCleared);
    on<HintRequested>(_onHintRequested);
    on<HintDismissed>(_onHintDismissed);
  }

  // ── 초기화 ────────────────────────────────────────────────
  Future<void> _onGameInitialized(
      GameInitialized event, Emitter<GameState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));

    final baseResult = await getBaseWordsUseCase();
    if (baseResult.isLeft()) {
      baseResult.fold(
            (error) => emit(state.copyWith(
            status: GameStatus.error, errorMessage: error)),
            (_) {},
      );
      return;
    }
    final baseWords = baseResult.getOrElse(() => []);

    final discoveredResult = await getDiscoveredWordsUseCase();
    final discoveredWords = discoveredResult.getOrElse(() => []);

    final extraWords = discoveredWords
        .where((d) => !baseWords.any((b) => b.id == d.id))
        .toList();
    final paletteWords = [...baseWords, ...extraWords];

    final canvasResult = await getCanvasWordsUseCase();
    final canvasWords = canvasResult.getOrElse(() => []);

    emit(state.copyWith(
      status: GameStatus.ready,
      paletteWords: paletteWords,
      discoveredWords: discoveredWords,
      canvasWords: canvasWords,
    ));
  }

  // ── 캔버스에 단어 배치 ────────────────────────────────────
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
    _persistCanvas(updated);
  }

  // ── 캔버스 단어 이동 ──────────────────────────────────────
  void _onCanvasWordMoved(
      CanvasWordMoved event, Emitter<GameState> emit) {
    final updated = state.canvasWords.map((cw) {
      if (cw.canvasId == event.canvasId) {
        return cw.copyWith(x: event.x, y: event.y);
      }
      return cw;
    }).toList();
    emit(state.copyWith(canvasWords: updated));
  }

  // ── 캔버스 드롭 → 합성 시도 ───────────────────────────────
  Future<void> _onWordDropped(
      WordDropped event, Emitter<GameState> emit) async {
    final dragged = state.canvasWords
        .where((cw) => cw.canvasId == event.draggedCanvasId)
        .firstOrNull;
    if (dragged == null) return;

    final nearest = _findNearest(
      state.canvasWords,
      event.dropX,
      event.dropY,
      excludeId: event.draggedCanvasId,
    );

    if (nearest == null) {
      _persistCanvas(state.canvasWords);
      return;
    }

    await _tryCombine(
      emit: emit,
      word1: dragged.word,
      word2: nearest.word,
      removeId1: dragged.canvasId,
      removeId2: nearest.canvasId,
      midX: (dragged.x + nearest.x) / 2,
      midY: (dragged.y + nearest.y) / 2,
      currentCanvas: state.canvasWords,
    );
  }

  // ── 팔레트 → 캔버스 드롭 + 즉시 합성 ─────────────────────
  Future<void> _onWordDroppedFromPalette(
      WordDroppedFromPalette event, Emitter<GameState> emit) async {
    // 1. 먼저 배치
    final newCanvasId = _generateCanvasId();
    final newCanvasWord = CanvasWord(
      canvasId: newCanvasId,
      word: event.word,
      x: event.x,
      y: event.y,
    );
    final placedCanvas = List<CanvasWord>.from(state.canvasWords)
      ..add(newCanvasWord);

    // 2. 기존 캔버스에서 합성 대상 탐색 (배치 전 canvasWords 기준)
    final nearest = _findNearest(
      state.canvasWords,
      event.x,
      event.y,
    );

    // 3. 합성 대상 없으면 배치만
    if (nearest == null) {
      emit(state.copyWith(canvasWords: placedCanvas));
      _persistCanvas(placedCanvas);
      return;
    }

    // 4. 합성 시도
    await _tryCombine(
      emit: emit,
      word1: event.word,
      word2: nearest.word,
      removeId1: newCanvasId,
      removeId2: nearest.canvasId,
      midX: (event.x + nearest.x) / 2,
      midY: (event.y + nearest.y) / 2,
      currentCanvas: placedCanvas,
    );
  }

  // ── 공용 합성 로직 ────────────────────────────────────────
  Future<void> _tryCombine({
    required Emitter<GameState> emit,
    required Word word1,
    required Word word2,
    required String removeId1,
    required String removeId2,
    required double midX,
    required double midY,
    required List<CanvasWord> currentCanvas,
  }) async {
    emit(state.copyWith(
      status: GameStatus.combining,
      canvasWords: currentCanvas,
    ));

    final result = await combineWordsUseCase(CombineWordsParams(
      word1Id: word1.id,
      word2Id: word2.id,
    ));

    await result.fold(
          (error) async {
        emit(state.copyWith(
          status: GameStatus.ready,
          canvasWords: currentCanvas,
        ));
        _persistCanvas(currentCanvas);
      },
          (combination) async {
        if (combination == null) {
          // 합성 레시피 없음
          emit(state.copyWith(
            status: GameStatus.ready,
            canvasWords: currentCanvas,
          ));
          _persistCanvas(currentCanvas);
          return;
        }

        // 합성 성공
        final newCombinedWord = CanvasWord(
          canvasId: _generateCanvasId(),
          word: combination.result,
          x: midX,
          y: midY,
        );

        final updatedCanvas = currentCanvas
            .where((cw) =>
        cw.canvasId != removeId1 && cw.canvasId != removeId2)
            .toList()
          ..add(newCombinedWord);

        final isNewDiscovery = !state.discoveredWords
            .any((w) => w.id == combination.result.id);

        List<Word> updatedDiscovered = List.from(state.discoveredWords);

        if (isNewDiscovery) {
          updatedDiscovered.add(combination.result);
          await saveDiscoveredWordUseCase(combination.result);

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
            _persistCanvas(updatedCanvas);
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
        _persistCanvas(updatedCanvas);
      },
    );
  }

  // ── 단어 삭제 ─────────────────────────────────────────────
  void _onCanvasWordDeleted(
      CanvasWordDeleted event, Emitter<GameState> emit) {
    final updated = state.canvasWords
        .where((cw) => cw.canvasId != event.canvasId)
        .toList();
    emit(state.copyWith(canvasWords: updated));
    _persistCanvas(updated);
  }

  // ── 합성 팝업 닫기 ────────────────────────────────────────
  void _onCombinationResultDismissed(
      CombinationResultDismissed event, Emitter<GameState> emit) {
    emit(state.copyWith(
      showCombinationResult: false,
      clearLastCombination: true,
    ));
  }

  // ── 캔버스 전체 초기화 ────────────────────────────────────
  void _onCanvasCleared(CanvasCleared event, Emitter<GameState> emit) {
    emit(state.copyWith(canvasWords: []));
    _persistCanvas([]);
  }

  // ── 힌트 요청 ─────────────────────────────────────────────
  void _onHintRequested(HintRequested event, Emitter<GameState> emit) {
    final available = WordDataRegistry.combinations.where((combo) {
      final w1 = combo['w1'] as String;
      final w2 = combo['w2'] as String;
      final resultId =
      (combo['result'] as Map<String, dynamic>)['id'] as String;

      final w1InPalette = state.paletteWords.any((w) => w.id == w1);
      final w2InPalette = state.paletteWords.any((w) => w.id == w2);
      final notDiscovered =
      !state.discoveredWords.any((w) => w.id == resultId);

      return w1InPalette && w2InPalette && notDiscovered;
    }).toList();

    if (available.isEmpty) return;

    final picked = available[Random().nextInt(available.length)];
    final resultMap = picked['result'] as Map<String, dynamic>;

    final hint = WordCombination(
      word1Id: picked['w1'] as String,
      word2Id: picked['w2'] as String,
      result: Word(
        id: resultMap['id'] as String,
        text: resultMap['text'] as String,
        emoji: resultMap['emoji'] as String,
        category: WordCategory.values.firstWhere(
              (e) => e.name == resultMap['category'],
          orElse: () => WordCategory.object,
        ),
        level: resultMap['level'] as int? ?? 1,
      ),
      description: picked['desc'] as String,
    );

    emit(state.copyWith(hintCombination: hint));
  }

  // ── 힌트 닫기 ─────────────────────────────────────────────
  void _onHintDismissed(HintDismissed event, Emitter<GameState> emit) {
    emit(state.copyWith(clearHint: true));
  }

  // ── 가장 많이 겹친 카드 탐색 헬퍼 ───────────────────────
  CanvasWord? _findNearest(
      List<CanvasWord> canvasWords,
      double x,
      double y, {
        String? excludeId,
      }) {
    CanvasWord? nearest;
    double bestOverlap = 0;

    for (final other in canvasWords) {
      if (excludeId != null && other.canvasId == excludeId) continue;

      final overlapX = (_cardW - (x - other.x).abs()).clamp(0.0, _cardW);
      final overlapY = (_cardH - (y - other.y).abs()).clamp(0.0, _cardH);
      final overlapArea = overlapX * overlapY;
      final cardArea = _cardW * _cardH;

      if (overlapArea / cardArea >= 0.5 && overlapArea > bestOverlap) {
        bestOverlap = overlapArea;
        nearest = other;
      }
    }
    return nearest;
  }

  // ── 캔버스 저장 헬퍼 ─────────────────────────────────────
  void _persistCanvas(List<CanvasWord> canvasWords) {
    saveCanvasWordsUseCase(canvasWords);
  }

  // ── 유틸 ─────────────────────────────────────────────────
  String _generateCanvasId() {
    return DateTime.now().microsecondsSinceEpoch.toString() +
        Random().nextInt(9999).toString();
  }
}