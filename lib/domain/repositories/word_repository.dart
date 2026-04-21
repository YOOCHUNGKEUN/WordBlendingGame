// lib/domain/repositories/word_repository.dart

import 'package:dartz/dartz.dart';
import '../entities/word.dart';
import '../entities/word_combination.dart';

abstract class WordRepository {
  /// 기본 단어 목록 가져오기
  Future<Either<String, List<Word>>> getBaseWords();

  /// 발견한 단어 목록 가져오기 (저장된 진행상황)
  Future<Either<String, List<Word>>> getDiscoveredWords();

  /// 발견한 단어 저장
  Future<Either<String, Unit>> saveDiscoveredWord(Word word);

  /// 두 단어의 합성 결과 가져오기
  Future<Either<String, WordCombination?>> getCombinationResult(
    String word1Id,
    String word2Id,
  );

  /// 모든 합성 레시피 가져오기
  Future<Either<String, List<WordCombination>>> getAllCombinations();
}
