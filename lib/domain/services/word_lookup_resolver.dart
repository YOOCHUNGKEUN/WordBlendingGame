// lib/domain/services/word_lookup_resolver.dart

import '../entities/canvas_word.dart';
import '../entities/word.dart';
import '../entities/word_combination.dart';

class WordLookupResolver {
  final List<Word> knownWords;
  final List<WordCombination> combinations;

  WordLookupResolver({
    required this.knownWords,
    required this.combinations,
  });

  // 게임 상태에 포함된 단어와 조합 결과를 이용해 resolver를 만든다.
  factory WordLookupResolver.fromGameState({
    required List<Word> paletteWords,
    required List<Word> discoveredWords,
    required List<CanvasWord> canvasWords,
    required List<WordCombination> combinations,
  }) {
    return WordLookupResolver(
      knownWords: [
        ...paletteWords,
        ...discoveredWords,
        ...canvasWords.map((canvasWord) => canvasWord.word),
        ...combinations.map((combination) => combination.result),
      ],
      combinations: combinations,
    );
  }

  // 결과 단어 기준으로 해당 단어를 만든 조합을 찾는다.
  WordCombination? findRecipeForWord(Word word) {
    for (final combination in combinations) {
      if (combination.result.id == word.id) {
        return combination;
      }
    }
    return null;
  }

  // 단어 id로 화면 표시용 텍스트와 이모지를 찾는다.
  Map<String, String> findWordInfo(String id) {
    final word = _findWordById(id);
    if (word == null) {
      return {'text': id, 'emoji': '❓'};
    }
    return {'text': word.text, 'emoji': word.emoji};
  }

  // 중복된 후보 중 가장 먼저 발견되는 단어를 반환한다.
  Word? _findWordById(String id) {
    for (final word in knownWords) {
      if (word.id == id) {
        return word;
      }
    }
    return null;
  }
}
