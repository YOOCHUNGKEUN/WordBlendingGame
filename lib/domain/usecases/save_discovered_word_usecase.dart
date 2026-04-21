// lib/domain/usecases/save_discovered_word_usecase.dart

import 'package:dartz/dartz.dart';
import '../entities/word.dart';
import '../repositories/word_repository.dart';

class SaveDiscoveredWordUseCase {
  final WordRepository repository;
  SaveDiscoveredWordUseCase(this.repository);

  Future<Either<String, Unit>> call(Word word) {
    return repository.saveDiscoveredWord(word);
  }
}
