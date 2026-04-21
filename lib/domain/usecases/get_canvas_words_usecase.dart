// lib/domain/usecases/get_canvas_words_usecase.dart

import 'package:dartz/dartz.dart';
import '../entities/canvas_word.dart';
import '../repositories/word_repository.dart';

class GetCanvasWordsUseCase {
  final WordRepository repository;
  GetCanvasWordsUseCase(this.repository);

  Future<Either<String, List<CanvasWord>>> call() => repository.getSavedCanvasWords();
}