// lib/data/datasources/word_data/word_data_registry.dart
//
// ════════════════════════════════════════════════════════
// 📋 단어 & 합성 규칙 레지스트리
//
// ✅ 기본 단어 추가 → base_words/ 해당 카테고리 파일에 추가
// ✅ 합성 규칙 추가 → combinations/ 해당 카테고리 파일에 추가
// ✅ 새 카테고리    → 새 파일 만들고 아래 리스트에 추가
// ════════════════════════════════════════════════════════

import 'base_words/nature_words.dart';
import 'base_words/weather_words.dart';
import 'base_words/animal_words.dart';
import 'base_words/food_words.dart';
import 'base_words/object_words.dart';
import 'combinations/nature_combinations.dart';
import 'combinations/weather_combinations.dart';
import 'combinations/plant_combinations.dart';
import 'combinations/food_combinations.dart';
import 'combinations/animal_combinations.dart';
import 'combinations/object_combinations.dart';
import 'combinations/advanced_combinations.dart';

class WordDataRegistry {
  WordDataRegistry._();

  // ── 기본 단어 목록 ──────────────────────────────────────
  // 새 카테고리 파일 추가 시 여기에 한 줄 추가
  static const List<Map<String, dynamic>> baseWords = [
    ...natureWords,
    ...weatherWords,
    ...animalWords,
    ...foodWords,
    ...objectWords,
  ];

  // ── 합성 규칙 목록 ──────────────────────────────────────
  // 새 합성 파일 추가 시 여기에 한 줄 추가
  static const List<Map<String, dynamic>> combinations = [
    ...natureCombinations,
    ...weatherCombinations,
    ...plantCombinations,
    ...foodCombinations,
    ...animalCombinations,
    ...objectCombinations,
    ...advancedCombinations,
  ];
}