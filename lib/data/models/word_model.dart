// lib/data/models/word_model.dart


import '../../core/constants/app_strings.dart';
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
      id: map[AppStrings.id] as String,
      text: map[AppStrings.text] as String,
      emoji: map[AppStrings.emoji] as String,
      category: _parseCategory(map[AppStrings.category] as String),
      level: map[AppStrings.level] as int? ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppStrings.id: id,
      AppStrings.text: text,
      AppStrings.emoji: emoji,
      AppStrings.category: category.name,
      AppStrings.level: level,
    };
  }

  static WordCategory _parseCategory(String value) {
    return WordCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => WordCategory.object,
    );
  }
}
