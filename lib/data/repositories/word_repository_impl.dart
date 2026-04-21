// lib/data/repositories/word_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../domain/entities/word.dart';
import '../../domain/entities/word_combination.dart';
import '../../domain/repositories/word_repository.dart';
import '../datasources/word_local_datasource.dart';
import '../models/word_model.dart';

class WordRepositoryImpl implements WordRepository {
  final WordLocalDataSource localDataSource;

  WordRepositoryImpl(this.localDataSource);

  @override
  Future<Either<String, List<Word>>> getBaseWords() async {
    try {
      final words = await localDataSource.getBaseWords();
      return Right(words);
    } catch (e) {
      return Left('단어를 불러오는데 실패했어요: $e');
    }
  }

  @override
  Future<Either<String, List<Word>>> getDiscoveredWords() async {
    try {
      final words = await localDataSource.getDiscoveredWords();
      return Right(words);
    } catch (e) {
      return Left('저장된 단어를 불러오는데 실패했어요: $e');
    }
  }

  @override
  Future<Either<String, Unit>> saveDiscoveredWord(Word word) async {
    try {
      await localDataSource.saveDiscoveredWord(WordModel(
        id: word.id,
        text: word.text,
        emoji: word.emoji,
        category: word.category,
        level: word.level,
      ));
      return const Right(unit);
    } catch (e) {
      return Left('단어 저장에 실패했어요: $e');
    }
  }

  @override
  Future<Either<String, WordCombination?>> getCombinationResult(
      String word1Id, String word2Id) async {
    try {
      final result =
          await localDataSource.getCombinationResult(word1Id, word2Id);
      return Right(result);
    } catch (e) {
      return Left('단어 합성에 실패했어요: $e');
    }
  }

  @override
  Future<Either<String, List<WordCombination>>> getAllCombinations() async {
    try {
      final combos = await localDataSource.getAllCombinations();
      return Right(combos);
    } catch (e) {
      return Left('레시피를 불러오는데 실패했어요: $e');
    }
  }
}
