const List<Map<String, dynamic>> natureCombinations = [
  {
    'w1': 'fire', 'w2': 'water',
    'result': {'id': 'steam', 'text': '수증기', 'emoji': '💨', 'category': 'weather', 'level': 2},
    'desc': '물을 뜨겁게 끓이면 기체인 수증기로 변해요. (증발)',
  },
  {
    'w1': 'water', 'w2': 'earth',
    'result': {'id': 'mud', 'text': '진흙', 'emoji': '🟫', 'category': 'nature', 'level': 2},
    'desc': '흙에 물이 섞이면 질척한 진흙이 돼요.',
  },
  {
    'w1': 'water', 'w2': 'wind',
    'result': {'id': 'wave', 'text': '파도', 'emoji': '🌊', 'category': 'nature', 'level': 2},
    'desc': '바람이 물 표면을 밀면 물결과 파도가 생겨요.',
  },
  {
    'w1': 'water', 'w2': 'stone',
    'result': {'id': 'river', 'text': '강', 'emoji': '🏞️', 'category': 'nature', 'level': 2},
    'desc': '물이 낮은 곳으로 흐르며 땅과 돌 사이에 물길을 만들어요.',
  },
  {
    'w1': 'earth', 'w2': 'stone',
    'result': {'id': 'mountain', 'text': '산', 'emoji': '⛰️', 'category': 'nature', 'level': 2},
    'desc': '흙과 암석이 오랜 시간 솟아오르고 쌓이면 산을 이루어요.',
  },
  {
    'w1': 'stone', 'w2': 'wind',
    'result': {'id': 'sand', 'text': '모래', 'emoji': '🏖️', 'category': 'nature', 'level': 2},
    'desc': '바람과 마찰이 오랫동안 돌을 깎으면 작은 모래 알갱이가 돼요. (풍화)',
  },
  {
    'w1': 'stone', 'w2': 'water',
    'result': {'id': 'pebble', 'text': '자갈', 'emoji': '🪨', 'category': 'nature', 'level': 2},
    'desc': '흐르는 물이 돌을 깎고 굴리면 둥근 자갈이 돼요.',
  },
  {
    'w1': 'earth', 'w2': 'wind',
    'result': {'id': 'dust', 'text': '먼지', 'emoji': '💨', 'category': 'nature', 'level': 2},
    'desc': '마른 흙의 아주 작은 알갱이가 바람에 날리면 먼지가 돼요.',
  },
  {
    'w1': 'sun', 'w2': 'water',
    'result': {'id': 'evaporation', 'text': '증발', 'emoji': '♨️', 'category': 'weather', 'level': 2},
    'desc': '햇빛이 물을 데우면 물이 수증기로 올라가요. (증발)',
  },
  {
    'w1': 'sun', 'w2': 'earth',
    'result': {'id': 'dry_soil', 'text': '마른 흙', 'emoji': '🏜️', 'category': 'nature', 'level': 2},
    'desc': '햇빛이 오래 비치면 흙 속 물기가 줄어 마른 흙이 돼요.',
  },
  {
    'w1': 'fire', 'w2': 'stone',
    'result': {'id': 'magma', 'text': '마그마', 'emoji': '🌋', 'category': 'nature', 'level': 2},
    'desc': '암석이 땅속의 아주 높은 열을 받으면 녹아 마그마가 될 수 있어요.',
  },
  {
    'w1': 'fire', 'w2': 'tree',
    'result': {'id': 'charcoal', 'text': '숯', 'emoji': '⬛', 'category': 'object', 'level': 2},
    'desc': '나무를 공기가 적은 곳에서 뜨겁게 만들면 숯이 돼요.',
  },
  {
    'w1': 'charcoal', 'w2': 'fire',
    'result': {'id': 'ash', 'text': '재', 'emoji': '🌫️', 'category': 'nature', 'level': 3},
    'desc': '숯이나 나무가 충분히 타고 나면 재가 남아요.',
  },
  {
    'w1': 'magma', 'w2': 'water',
    'result': {'id': 'basalt', 'text': '현무암', 'emoji': '⬛', 'category': 'nature', 'level': 3},
    'desc': '뜨거운 마그마가 빠르게 식으면 현무암 같은 화산암이 될 수 있어요.',
  },
  {
    'w1': 'sand', 'w2': 'water',
    'result': {'id': 'beach', 'text': '해변', 'emoji': '🏖️', 'category': 'nature', 'level': 3},
    'desc': '모래가 물가에 쌓이면 해변이 만들어져요.',
  },
  {
    'w1': 'mountain', 'w2': 'snow',
    'result': {'id': 'snowy_peak', 'text': '설산', 'emoji': '🏔️', 'category': 'nature', 'level': 3},
    'desc': '높은 산 위에 눈이 쌓이면 설산처럼 보여요.',
  },
];
