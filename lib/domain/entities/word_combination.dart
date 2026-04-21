// lib/domain/entities/word_combination.dart

import 'package:equatable/equatable.dart';
import 'word.dart';

class WordCombination extends Equatable {
  final String word1Id;
  final String word2Id;
  final Word result;
  final String description; // 왜 합쳐지는지 설명 (교육적 내용)

  const WordCombination({
    required this.word1Id,
    required this.word2Id,
    required this.result,
    required this.description,
  });

  @override
  List<Object?> get props => [word1Id, word2Id, result, description];
}
