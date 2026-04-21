// lib/data/datasources/word_combination_data.dart
//
// 유아 교육용 단어 합성 규칙
// 과학적/언어적 규칙 기반: 실제 한국어 합성어 or 개념 결합

import '../../domain/entities/word.dart';
import '../../domain/entities/word_combination.dart';

class WordCombinationData {
  // ══════════════════════════════════════════
  // 기본 단어 (레벨 1)
  // ══════════════════════════════════════════
  static const List<Map<String, dynamic>> baseWords = [
    // 자연
    {'id': 'fire',    'text': '불',   'emoji': '🔥', 'category': 'nature'},
    {'id': 'water',   'text': '물',   'emoji': '💧', 'category': 'nature'},
    {'id': 'earth',   'text': '흙',   'emoji': '🌍', 'category': 'nature'},
    {'id': 'wind',    'text': '바람', 'emoji': '💨', 'category': 'weather'},
    {'id': 'sun',     'text': '해',   'emoji': '☀️', 'category': 'nature'},
    {'id': 'snow',    'text': '눈',   'emoji': '❄️', 'category': 'weather'},
    {'id': 'rain',    'text': '비',   'emoji': '🌧️', 'category': 'weather'},
    {'id': 'tree',    'text': '나무', 'emoji': '🌳', 'category': 'nature'},
    {'id': 'flower',  'text': '꽃',   'emoji': '🌸', 'category': 'nature'},
    {'id': 'seed',    'text': '씨앗', 'emoji': '🌱', 'category': 'nature'},
    {'id': 'stone',   'text': '돌',   'emoji': '🪨', 'category': 'nature'},
    {'id': 'cloud',   'text': '구름', 'emoji': '☁️', 'category': 'weather'},
    // 동물
    {'id': 'bird',    'text': '새',   'emoji': '🐦', 'category': 'animal'},
    {'id': 'fish',    'text': '물고기','emoji': '🐟', 'category': 'animal'},
    {'id': 'cow',     'text': '소',   'emoji': '🐄', 'category': 'animal'},
    {'id': 'pig',     'text': '돼지', 'emoji': '🐷', 'category': 'animal'},
    // 음식
    {'id': 'rice',    'text': '쌀',   'emoji': '🌾', 'category': 'food'},
    {'id': 'milk',    'text': '우유', 'emoji': '🥛', 'category': 'food'},
    // 사물
    {'id': 'house',   'text': '집',   'emoji': '🏠', 'category': 'object'},
    {'id': 'book',    'text': '책',   'emoji': '📚', 'category': 'object'},
  ];

  // ══════════════════════════════════════════
  // 합성 규칙 (교육적 근거 포함)
  // ══════════════════════════════════════════
  static const List<Map<String, dynamic>> combinations = [
    // ── 자연 현상 기반 ──────────────────────
    {
      'w1': 'fire', 'w2': 'water',
      'result': {'id': 'steam', 'text': '수증기', 'emoji': '💨', 'category': 'weather', 'level': 2},
      'desc': '불로 물을 끓이면 수증기가 돼요! (물의 상태 변화)'
    },
    {
      'w1': 'water', 'w2': 'earth',
      'result': {'id': 'mud', 'text': '진흙', 'emoji': '🟫', 'category': 'nature', 'level': 2},
      'desc': '물과 흙이 만나면 진흙이 돼요!'
    },
    {
      'w1': 'water', 'w2': 'wind',
      'result': {'id': 'wave', 'text': '파도', 'emoji': '🌊', 'category': 'nature', 'level': 2},
      'desc': '바람이 물 위를 불면 파도가 생겨요!'
    },
    {
      'w1': 'fire', 'w2': 'earth',
      'result': {'id': 'lava', 'text': '용암', 'emoji': '🌋', 'category': 'nature', 'level': 2},
      'desc': '땅속 깊은 곳에서 불과 흙이 만나 용암이 돼요!'
    },
    {
      'w1': 'water', 'w2': 'cloud',
      'result': {'id': 'rain', 'text': '비', 'emoji': '🌧️', 'category': 'weather', 'level': 1},
      'desc': '구름 속 물방울이 무거워지면 비가 내려요! (물의 순환)'
    },
    {
      'w1': 'cloud', 'w2': 'wind',
      'result': {'id': 'storm', 'text': '폭풍', 'emoji': '⛈️', 'category': 'weather', 'level': 2},
      'desc': '구름과 바람이 세게 만나면 폭풍이 돼요!'
    },
    {
      'w1': 'rain', 'w2': 'sun',
      'result': {'id': 'rainbow', 'text': '무지개', 'emoji': '🌈', 'category': 'nature', 'level': 2},
      'desc': '비가 온 뒤 햇빛이 나면 무지개가 생겨요! (빛의 굴절)'
    },
    {
      'w1': 'water', 'w2': 'snow',
      'result': {'id': 'ice', 'text': '얼음', 'emoji': '🧊', 'category': 'nature', 'level': 2},
      'desc': '물이 차가워지면 얼음이 돼요! (물의 상태 변화)'
    },
    {
      'w1': 'snow', 'w2': 'wind',
      'result': {'id': 'blizzard', 'text': '눈보라', 'emoji': '🌨️', 'category': 'weather', 'level': 2},
      'desc': '눈과 바람이 만나면 눈보라가 돼요!'
    },
    {
      'w1': 'fire', 'w2': 'wind',
      'result': {'id': 'wildfire', 'text': '산불', 'emoji': '🏔️', 'category': 'nature', 'level': 2},
      'desc': '바람이 불을 더 크게 만들어요! 불조심!'
    },
    // ── 식물 성장 기반 ──────────────────────
    {
      'w1': 'seed', 'w2': 'water',
      'result': {'id': 'sprout', 'text': '새싹', 'emoji': '🌱', 'category': 'nature', 'level': 2},
      'desc': '씨앗에 물을 주면 새싹이 나요! (식물의 성장)'
    },
    {
      'w1': 'sprout', 'w2': 'sun',
      'result': {'id': 'tree', 'text': '나무', 'emoji': '🌳', 'category': 'nature', 'level': 1},
      'desc': '새싹이 햇빛을 받으면 나무로 자라요! (광합성)'
    },
    {
      'w1': 'tree', 'w2': 'flower',
      'result': {'id': 'garden', 'text': '정원', 'emoji': '🌺', 'category': 'nature', 'level': 2},
      'desc': '나무와 꽃이 모이면 예쁜 정원이 돼요!'
    },
    {
      'w1': 'seed', 'w2': 'earth',
      'result': {'id': 'sprout', 'text': '새싹', 'emoji': '🌱', 'category': 'nature', 'level': 2},
      'desc': '씨앗을 흙에 심으면 새싹이 돼요!'
    },
    {
      'w1': 'tree', 'w2': 'fire',
      'result': {'id': 'charcoal', 'text': '숯', 'emoji': '⬛', 'category': 'object', 'level': 2},
      'desc': '나무를 태우면 숯이 돼요!'
    },
    // ── 음식/요리 기반 ──────────────────────
    {
      'w1': 'rice', 'w2': 'water',
      'result': {'id': 'porridge', 'text': '죽', 'emoji': '🍚', 'category': 'food', 'level': 2},
      'desc': '쌀에 물을 많이 넣고 끓이면 죽이 돼요!'
    },
    {
      'w1': 'rice', 'w2': 'fire',
      'result': {'id': 'cooked_rice', 'text': '밥', 'emoji': '🍙', 'category': 'food', 'level': 2},
      'desc': '쌀을 불로 지으면 맛있는 밥이 돼요!'
    },
    {
      'w1': 'milk', 'w2': 'fire',
      'result': {'id': 'hot_milk', 'text': '따뜻한 우유', 'emoji': '🥛', 'category': 'food', 'level': 2},
      'desc': '우유를 데우면 따뜻한 우유가 돼요!'
    },
    {
      'w1': 'cow', 'w2': 'milk',
      'result': {'id': 'butter', 'text': '버터', 'emoji': '🧈', 'category': 'food', 'level': 2},
      'desc': '소의 우유를 오래 흔들면 버터가 돼요!'
    },
    // ── 동물 합성 ──────────────────────────
    {
      'w1': 'bird', 'w2': 'water',
      'result': {'id': 'duck', 'text': '오리', 'emoji': '🦆', 'category': 'animal', 'level': 2},
      'desc': '물에서 헤엄치는 새는 오리예요!'
    },
    {
      'w1': 'fish', 'w2': 'earth',
      'result': {'id': 'crab', 'text': '게', 'emoji': '🦀', 'category': 'animal', 'level': 2},
      'desc': '바닷가 돌 틈에 사는 물고기 친구는 게예요!'
    },
    // ── 집/생활 ────────────────────────────
    {
      'w1': 'house', 'w2': 'tree',
      'result': {'id': 'treehouse', 'text': '나무집', 'emoji': '🏡', 'category': 'object', 'level': 2},
      'desc': '나무 위에 지은 집이 나무집이에요!'
    },
    {
      'w1': 'house', 'w2': 'fire',
      'result': {'id': 'fireplace', 'text': '벽난로', 'emoji': '🪵', 'category': 'object', 'level': 2},
      'desc': '집 안에 있는 불이 벽난로예요!'
    },
    {
      'w1': 'stone', 'w2': 'house',
      'result': {'id': 'castle', 'text': '성', 'emoji': '🏰', 'category': 'object', 'level': 2},
      'desc': '돌로 크게 쌓아 만든 집이 성이에요!'
    },
    // ── 레벨 2 합성 (합성어 + 기본어) ──────
    {
      'w1': 'steam', 'w2': 'wind',
      'result': {'id': 'fog', 'text': '안개', 'emoji': '🌫️', 'category': 'weather', 'level': 3},
      'desc': '수증기와 바람이 만나 안개가 돼요!'
    },
    {
      'w1': 'mud', 'w2': 'fire',
      'result': {'id': 'brick', 'text': '벽돌', 'emoji': '🧱', 'category': 'object', 'level': 3},
      'desc': '진흙을 불에 구우면 단단한 벽돌이 돼요!'
    },
    {
      'w1': 'lava', 'w2': 'water',
      'result': {'id': 'obsidian', 'text': '현무암', 'emoji': '⬛', 'category': 'nature', 'level': 3},
      'desc': '용암이 물에 닿아 식으면 현무암이 돼요! (화산암)'
    },
    {
      'w1': 'ice', 'w2': 'fire',
      'result': {'id': 'water', 'text': '물', 'emoji': '💧', 'category': 'nature', 'level': 1},
      'desc': '얼음을 불로 녹이면 다시 물이 돼요! (상태 변화)'
    },
    {
      'w1': 'rainbow', 'w2': 'cloud',
      'result': {'id': 'magic', 'text': '마법', 'emoji': '✨', 'category': 'compound', 'level': 3},
      'desc': '무지개와 구름이 만나면 마법같은 일이 생겨요!'
    },
    {
      'w1': 'wave', 'w2': 'wind',
      'result': {'id': 'storm', 'text': '폭풍', 'emoji': '⛈️', 'category': 'weather', 'level': 2},
      'desc': '파도와 바람이 만나면 폭풍이 돼요!'
    },
    {
      'w1': 'brick', 'w2': 'house',
      'result': {'id': 'castle', 'text': '성', 'emoji': '🏰', 'category': 'object', 'level': 3},
      'desc': '벽돌로 크게 쌓으면 멋진 성이 돼요!'
    },
    {
      'w1': 'charcoal', 'w2': 'fire',
      'result': {'id': 'diamond', 'text': '다이아몬드', 'emoji': '💎', 'category': 'nature', 'level': 3},
      'desc': '탄소(숯)에 엄청난 열과 압력을 가하면 다이아몬드가 돼요!'
    },
  ];
}
