// lib/domain/usecases/get_all_combinations_usecase.dart

import 'package:dartz/dartz.dart';

import '../entities/word_combination.dart';
import '../repositories/word_repository.dart';

class GetAllCombinationsUseCase {
  final WordRepository repository;

  GetAllCombinationsUseCase(this.repository);

  // 저장소에서 전체 단어 조합 목록을 가져온다.
  Future<Either<String, List<WordCombination>>> call() {
    return repository.getAllCombinations();
  }
}
