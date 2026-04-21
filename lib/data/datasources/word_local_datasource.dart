// lib/data/datasources/word_local_datasource.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word_model.dart';
import '../../domain/entities/word_combination.dart';
import 'word_combination_data.dart';

abstract class WordLocalDataSource {
  Future<List<WordModel>> getBaseWords();
  Future<List<WordModel>> getDiscoveredWords();
  Future<void> saveDiscoveredWord(WordModel word);
  Future<WordCombination?> getCombinationResult(String word1Id, String word2Id);
  Future<List<WordCombination>> getAllCombinations();
}

class WordLocalDataSourceImpl implements WordLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _discoveredKey = 'discovered_words';

  WordLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<WordModel>> getBaseWords() async {
    return WordCombinationData.baseWords
        .map((map) => WordModel.fromMap(map))
        .toList();
  }

  @override
  Future<List<WordModel>> getDiscoveredWords() async {
    final jsonString = sharedPreferences.getString(_discoveredKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => WordModel.fromMap(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> saveDiscoveredWord(WordModel word) async {
    final current = await getDiscoveredWords();
    // 중복 방지
    if (current.any((w) => w.id == word.id)) return;
    current.add(word);
    final jsonString = json.encode(current.map((w) => w.toMap()).toList());
    await sharedPreferences.setString(_discoveredKey, jsonString);
  }

  @override
  Future<WordCombination?> getCombinationResult(
      String word1Id, String word2Id) async {
    for (final combo in WordCombinationData.combinations) {
      final w1 = combo['w1'] as String;
      final w2 = combo['w2'] as String;
      // 순서 무관하게 합성 가능
      if ((w1 == word1Id && w2 == word2Id) ||
          (w1 == word2Id && w2 == word1Id)) {
        final resultMap = combo['result'] as Map<String, dynamic>;
        final resultWord = WordModel.fromMap(resultMap);
        return WordCombination(
          word1Id: word1Id,
          word2Id: word2Id,
          result: resultWord,
          description: combo['desc'] as String,
        );
      }
    }
    return null;
  }

  @override
  Future<List<WordCombination>> getAllCombinations() async {
    return WordCombinationData.combinations.map((combo) {
      final resultMap = combo['result'] as Map<String, dynamic>;
      final resultWord = WordModel.fromMap(resultMap);
      return WordCombination(
        word1Id: combo['w1'] as String,
        word2Id: combo['w2'] as String,
        result: resultWord,
        description: combo['desc'] as String,
      );
    }).toList();
  }
}
