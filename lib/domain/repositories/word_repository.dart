// lib/domain/repositories/word_repository.dart

import 'package:dartz/dartz.dart';
import '../entities/canvas_word.dart';
import '../entities/word.dart';
import '../entities/word_combination.dart';

abstract class WordRepository {
  Future<Either<String, List<Word>>> getBaseWords();
  Future<Either<String, List<Word>>> getDiscoveredWords();
  Future<Either<String, Unit>> saveDiscoveredWord(Word word);
  Future<Either<String, WordCombination?>> getCombinationResult(String word1Id, String word2Id);
  Future<Either<String, List<WordCombination>>> getAllCombinations();

  // 캔버스 저장/복원
  Future<Either<String, List<CanvasWord>>> getSavedCanvasWords();
  Future<Either<String, Unit>> saveCanvasWords(List<CanvasWord> canvasWords);
}