// lib/domain/usecases/combine_words_usecase.dart

import 'package:dartz/dartz.dart';
import '../entities/word_combination.dart';
import '../repositories/word_repository.dart';

class CombineWordsParams {
  final String word1Id;
  final String word2Id;
  CombineWordsParams({required this.word1Id, required this.word2Id});
}

class CombineWordsUseCase {
  final WordRepository repository;
  CombineWordsUseCase(this.repository);

  Future<Either<String, WordCombination?>> call(CombineWordsParams params) {
    return repository.getCombinationResult(params.word1Id, params.word2Id);
  }
}
