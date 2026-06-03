const List<Map<String, dynamic>> foodCombinations = [
  {
    'w1': 'rice', 'w2': 'water',
    'result': {'id': 'porridge', 'text': '죽', 'emoji': '🍚', 'category': 'food', 'level': 2},
    'desc': '쌀에 물을 많이 넣고 끓이면 부드러운 죽이 돼요.',
  },
  {
    'w1': 'rice', 'w2': 'fire',
    'result': {'id': 'cooked_rice', 'text': '밥', 'emoji': '🍚', 'category': 'food', 'level': 2},
    'desc': '쌀에 물을 넣고 열을 가하면 밥이 돼요.',
  },
  {
    'w1': 'cooked_rice', 'w2': 'fire',
    'result': {'id': 'nurungji', 'text': '누룽지', 'emoji': '🍘', 'category': 'food', 'level': 3},
    'desc': '밥을 더 오래 가열하면 바닥이 마르고 눌어 누룽지가 돼요.',
  },
  {
    'w1': 'milk', 'w2': 'fire',
    'result': {'id': 'hot_milk', 'text': '따뜻한 우유', 'emoji': '🥛', 'category': 'food', 'level': 2},
    'desc': '우유에 열을 가하면 따뜻한 우유가 돼요.',
  },
  {
    'w1': 'milk', 'w2': 'frost',
    'result': {'id': 'icecream', 'text': '아이스크림', 'emoji': '🍦', 'category': 'food', 'level': 2},
    'desc': '우유와 당분을 차갑게 얼리면 아이스크림을 만들 수 있어요.',
  },
  {
    'w1': 'milk', 'w2': 'salt',
    'result': {'id': 'cheese', 'text': '치즈', 'emoji': '🧀', 'category': 'food', 'level': 2},
    'desc': '우유를 굳히고 소금을 더해 숙성하면 치즈가 돼요.',
  },
  {
    'w1': 'egg', 'w2': 'fire',
    'result': {'id': 'cooked_egg', 'text': '익힌 달걀', 'emoji': '🍳', 'category': 'food', 'level': 2},
    'desc': '달걀은 열을 받으면 단백질이 굳어 익은 달걀이 돼요.',
  },
  {
    'w1': 'flour', 'w2': 'water',
    'result': {'id': 'dough', 'text': '반죽', 'emoji': '🥣', 'category': 'food', 'level': 2},
    'desc': '밀가루에 물을 섞으면 끈적한 반죽이 돼요.',
  },
  {
    'w1': 'dough', 'w2': 'fire',
    'result': {'id': 'bread', 'text': '빵', 'emoji': '🍞', 'category': 'food', 'level': 3},
    'desc': '반죽을 오븐처럼 뜨거운 곳에서 익히면 빵이 돼요.',
  },
  {
    'w1': 'sugar', 'w2': 'water',
    'result': {'id': 'syrup', 'text': '시럽', 'emoji': '🍯', 'category': 'food', 'level': 2},
    'desc': '설탕은 물에 녹아 달콤한 시럽이 될 수 있어요.',
  },
  {
    'w1': 'fruit', 'w2': 'sugar',
    'result': {'id': 'jam', 'text': '잼', 'emoji': '🍓', 'category': 'food', 'level': 2},
    'desc': '과일에 설탕을 넣고 졸이면 잼을 만들 수 있어요.',
  },
  {
    'w1': 'bean', 'w2': 'water',
    'result': {'id': 'soaked_bean', 'text': '불린 콩', 'emoji': '🫘', 'category': 'food', 'level': 2},
    'desc': '마른 콩은 물을 흡수하면 부드럽게 불어요.',
  },
  {
    'w1': 'bean', 'w2': 'fire',
    'result': {'id': 'roasted_bean', 'text': '볶은 콩', 'emoji': '🫘', 'category': 'food', 'level': 2},
    'desc': '콩을 열로 볶으면 고소한 볶은 콩이 돼요.',
  },
  {
    'w1': 'vegetable', 'w2': 'water',
    'result': {'id': 'vegetable_soup', 'text': '채소국', 'emoji': '🍲', 'category': 'food', 'level': 2},
    'desc': '채소를 물에 넣고 끓이면 채소국을 만들 수 있어요.',
  },
  {
    'w1': 'meat', 'w2': 'fire',
    'result': {'id': 'cooked_meat', 'text': '구운 고기', 'emoji': '🥩', 'category': 'food', 'level': 2},
    'desc': '고기는 열을 받으면 익어서 먹기 쉬워져요.',
  },
  {
    'w1': 'raw_fish', 'w2': 'fire',
    'result': {'id': 'grilled_fish', 'text': '생선구이', 'emoji': '🐟', 'category': 'food', 'level': 2},
    'desc': '생선을 불에 익히면 생선구이가 돼요.',
  },
];
