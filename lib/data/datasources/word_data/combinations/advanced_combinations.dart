const List<Map<String, dynamic>> advancedCombinations = [
  {
    'w1': 'evaporation', 'w2': 'cloud',
    'result': {'id': 'rain', 'text': '비', 'emoji': '🌧️', 'category': 'weather', 'level': 1},
    'desc': '증발한 수증기가 구름을 이루고 물방울로 모이면 비가 내려요.',
  },
  {
    'w1': 'dust', 'w2': 'water',
    'result': {'id': 'mud', 'text': '진흙', 'emoji': '🟫', 'category': 'nature', 'level': 2},
    'desc': '먼지와 흙 알갱이에 물이 섞이면 진흙처럼 뭉쳐요.',
  },
  {
    'w1': 'pebble', 'w2': 'water',
    'result': {'id': 'riverbed', 'text': '강바닥', 'emoji': '🏞️', 'category': 'nature', 'level': 3},
    'desc': '흐르는 물 아래에는 자갈과 모래가 쌓여 강바닥을 만들어요.',
  },
  {
    'w1': 'wave', 'w2': 'stone',
    'result': {'id': 'sand', 'text': '모래', 'emoji': '🏖️', 'category': 'nature', 'level': 3},
    'desc': '파도가 오랫동안 돌을 때리고 깎으면 모래가 생길 수 있어요.',
  },
  {
    'w1': 'glacier', 'w2': 'stone',
    'result': {'id': 'valley', 'text': '계곡', 'emoji': '🏞️', 'category': 'nature', 'level': 3},
    'desc': '빙하가 천천히 움직이며 암석을 깎으면 깊은 계곡을 만들 수 있어요.',
  },
  {
    'w1': 'oxygen', 'w2': 'fire',
    'result': {'id': 'flame', 'text': '불꽃', 'emoji': '🔥', 'category': 'nature', 'level': 3},
    'desc': '불이 계속 타려면 산소가 필요해요.',
  },
  {
    'w1': 'ash', 'w2': 'earth',
    'result': {'id': 'fertile_soil', 'text': '기름진 흙', 'emoji': '🌱', 'category': 'nature', 'level': 3},
    'desc': '적은 양의 재는 흙에 무기질을 더해 식물이 자라는 데 도움을 줄 수 있어요.',
  },
  {
    'w1': 'syrup', 'w2': 'fruit',
    'result': {'id': 'jam', 'text': '잼', 'emoji': '🍓', 'category': 'food', 'level': 2},
    'desc': '과일을 달콤한 시럽과 함께 졸이면 잼이 돼요.',
  },
  {
    'w1': 'dough', 'w2': 'egg',
    'result': {'id': 'pancake_batter', 'text': '팬케이크 반죽', 'emoji': '🥞', 'category': 'food', 'level': 3},
    'desc': '반죽에 달걀을 섞으면 더 부드러운 팬케이크 반죽이 돼요.',
  },
  {
    'w1': 'pancake_batter', 'w2': 'fire',
    'result': {'id': 'pancake', 'text': '팬케이크', 'emoji': '🥞', 'category': 'food', 'level': 3},
    'desc': '팬케이크 반죽을 뜨겁게 익히면 팬케이크가 돼요.',
  },
];
