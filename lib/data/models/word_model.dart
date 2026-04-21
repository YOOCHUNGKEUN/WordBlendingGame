// lib/data/models/word_model.dart

import '../../domain/entities/word.dart';

class WordModel extends Word {
  const WordModel({
    required super.id,
    required super.text,
    required super.emoji,
    required super.category,
    super.level,
  });

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map['id'] as String,
      text: map['text'] as String,
      emoji: map['emoji'] as String,
      category: _parseCategory(map['category'] as String),
      level: map['level'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'emoji': emoji,
      'category': category.name,
      'level': level,
    };
  }

  static WordCategory _parseCategory(String value) {
    return WordCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => WordCategory.object,
    );
  }
}
