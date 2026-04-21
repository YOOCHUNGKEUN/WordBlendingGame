// lib/data/datasources/word_local_datasource.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_alchemy_new/core/constants/app_strings.dart';
import 'package:word_alchemy_new/data/datasources/word_data/word_data_registry.dart';
import '../models/word_model.dart';
import '../../domain/entities/canvas_word.dart';
import '../../domain/entities/word_combination.dart';

abstract class WordLocalDataSource {
  Future<List<WordModel>> getBaseWords();
  Future<List<WordModel>> getDiscoveredWords();
  Future<void> saveDiscoveredWord(WordModel word);
  Future<WordCombination?> getCombinationResult(String word1Id, String word2Id);
  Future<List<WordCombination>> getAllCombinations();
  // 캔버스 저장/복원
  Future<List<Map<String, dynamic>>> getSavedCanvasWords();
  Future<void> saveCanvasWords(List<CanvasWord> canvasWords);
}

class WordLocalDataSourceImpl implements WordLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _discoveredKey = AppStrings.shefkey_discovered_words;
  static const String _canvasKey = AppStrings.shefkey_canvas_words; // 캔버스 저장 키

  WordLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<WordModel>> getBaseWords() async {
    return WordDataRegistry.baseWords.map((map) => WordModel.fromMap(map)).toList();
  }

  @override
  Future<List<WordModel>> getDiscoveredWords() async {
    final jsonString = sharedPreferences.getString(_discoveredKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((e) => WordModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveDiscoveredWord(WordModel word) async {
    final current = await getDiscoveredWords();
    if (current.any((w) => w.id == word.id)) return;
    current.add(word);
    final jsonString = json.encode(current.map((w) => w.toMap()).toList());
    await sharedPreferences.setString(_discoveredKey, jsonString);
  }

  @override
  Future<WordCombination?> getCombinationResult(
      String word1Id, String word2Id) async {
    for (final combo in WordDataRegistry.combinations) {
      final w1 = combo[AppStrings.combo_w1] as String;
      final w2 = combo[AppStrings.combo_w2] as String;
      if ((w1 == word1Id && w2 == word2Id) ||
          (w1 == word2Id && w2 == word1Id)) {
        final resultMap = combo[AppStrings.combo_result] as Map<String, dynamic>;
        final resultWord = WordModel.fromMap(resultMap);
        return WordCombination(
          word1Id: word1Id,
          word2Id: word2Id,
          result: resultWord,
          description: combo[AppStrings.combo_desc] as String,
        );
      }
    }
    return null;
  }

  @override
  Future<List<WordCombination>> getAllCombinations() async {
    return WordDataRegistry.combinations.map((combo) {
      final resultMap = combo[AppStrings.combo_result] as Map<String, dynamic>;
      final resultWord = WordModel.fromMap(resultMap);
      return WordCombination(
        word1Id: combo[AppStrings.combo_w1] as String,
        word2Id: combo[AppStrings.combo_w2] as String,
        result: resultWord,
        description: combo[AppStrings.combo_desc] as String,
      );
    }).toList();
  }

  // ── 캔버스 저장 ───────────────────────────────────────────
  @override
  Future<List<Map<String, dynamic>>> getSavedCanvasWords() async {
    final jsonString = sharedPreferences.getString(_canvasKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.cast<Map<String, dynamic>>();
  }

  @override
  Future<void> saveCanvasWords(List<CanvasWord> canvasWords) async {
    final jsonList = canvasWords.map((cw) => {
      AppStrings.mapkey_canvasId: cw.canvasId,
      AppStrings.mapkey_x: cw.x,
      AppStrings.mapkey_y: cw.y,
      AppStrings.mapkey_word: WordModel(
        id: cw.word.id,
        text: cw.word.text,
        emoji: cw.word.emoji,
        category: cw.word.category,
        level: cw.word.level,
      ).toMap(),
    }).toList();
    await sharedPreferences.setString(_canvasKey, json.encode(jsonList));
  }
}