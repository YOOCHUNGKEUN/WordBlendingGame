// lib/domain/entities/word.dart

import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String id;
  final String text;
  final String emoji;
  final WordCategory category;
  final int level; // 1=기본, 2=합성1단계, 3=합성2단계

  const Word({
    required this.id,
    required this.text,
    required this.emoji,
    required this.category,
    this.level = 1,
  });

  @override
  List<Object?> get props => [id, text, emoji, category, level];
}

enum WordCategory {
  nature,    // 자연
  animal,    // 동물
  food,      // 음식
  weather,   // 날씨
  body,      // 신체
  object,    // 사물
  compound,  // 합성어
}
