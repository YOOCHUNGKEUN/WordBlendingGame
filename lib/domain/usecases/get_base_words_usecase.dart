// lib/domain/usecases/get_base_words_usecase.dart

import 'package:dartz/dartz.dart';
import '../entities/word.dart';
import '../repositories/word_repository.dart';

class GetBaseWordsUseCase {
  final WordRepository repository;
  GetBaseWordsUseCase(this.repository);

  Future<Either<String, List<Word>>> call() => repository.getBaseWords();
}
