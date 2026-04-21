// lib/data/repositories/word_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/canvas_word.dart';
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
      return Left('${AppStrings.get_word_error}: $e');
    }
  }

  @override
  Future<Either<String, List<Word>>> getDiscoveredWords() async {
    try {
      final words = await localDataSource.getDiscoveredWords();
      return Right(words);
    } catch (e) {
      return Left('${AppStrings.save_word_error}: $e');
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
      return Left('${AppStrings.save_word_failed}: $e');
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
      return Left('${AppStrings.blending_failed_word}: $e');
    }
  }

  @override
  Future<Either<String, List<WordCombination>>> getAllCombinations() async {
    try {
      final combos = await localDataSource.getAllCombinations();
      return Right(combos);
    } catch (e) {
      return Left('${AppStrings.blending_failed_recipe}: $e');
    }
  }

  // ── 캔버스 저장/복원 ──────────────────────────────────────
  @override
  Future<Either<String, List<CanvasWord>>> getSavedCanvasWords() async {
    try {
      final rawList = await localDataSource.getSavedCanvasWords();
      final canvasWords = rawList.map((map) {
        final wordMap = map[AppStrings.mapkey_word] as Map<String, dynamic>;
        return CanvasWord(
          canvasId: map[AppStrings.mapkey_canvasId] as String,
          x: (map[AppStrings.mapkey_x] as num).toDouble(),
          y: (map[AppStrings.mapkey_y] as num).toDouble(),
          word: WordModel.fromMap(wordMap),
        );
      }).toList();
      return Right(canvasWords);
    } catch (e) {
      return Left('${AppStrings.get_canvas_failed}: $e');
    }
  }

  @override
  Future<Either<String, Unit>> saveCanvasWords(
      List<CanvasWord> canvasWords) async {
    try {
      await localDataSource.saveCanvasWords(canvasWords);
      return const Right(unit);
    } catch (e) {
      return Left('${AppStrings.save_canvas_failed}: $e');
    }
  }
}