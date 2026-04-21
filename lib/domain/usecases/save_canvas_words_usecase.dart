// lib/domain/usecases/save_canvas_words_usecase.dart

import 'package:dartz/dartz.dart';
import '../entities/canvas_word.dart';
import '../repositories/word_repository.dart';

class SaveCanvasWordsUseCase {
  final WordRepository repository;
  SaveCanvasWordsUseCase(this.repository);

  Future<Either<String, Unit>> call(List<CanvasWord> canvasWords) => repository.saveCanvasWords(canvasWords);
}