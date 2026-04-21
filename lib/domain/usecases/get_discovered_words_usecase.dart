// lib/domain/usecases/get_discovered_words_usecase.dart

import 'package:dartz/dartz.dart';
import '../entities/word.dart';
import '../repositories/word_repository.dart';

class GetDiscoveredWordsUseCase {
  final WordRepository repository;
  GetDiscoveredWordsUseCase(this.repository);

  Future<Either<String, List<Word>>> call() => repository.getDiscoveredWords();
}