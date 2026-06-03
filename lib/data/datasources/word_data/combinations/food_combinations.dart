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
  {
    'w1': 'potato', 'w2': 'fire',
    'result': {'id': 'baked_potato', 'text': '군감자', 'emoji': '🥔', 'category': 'food', 'level': 2},
    'desc': '감자를 뜨겁게 익히면 포슬포슬한 군감자가 돼요.',
  },
  {
    'w1': 'potato', 'w2': 'oil',
    'result': {'id': 'fries', 'text': '감자튀김', 'emoji': '🍟', 'category': 'food', 'level': 2},
    'desc': '감자를 기름에 튀기면 바삭한 감자튀김이 돼요.',
  },
  {
    'w1': 'corn', 'w2': 'fire',
    'result': {'id': 'popcorn', 'text': '팝콘', 'emoji': '🍿', 'category': 'food', 'level': 2},
    'desc': '옥수수 알갱이를 뜨겁게 가열하면 안의 수분이 팽창해 팝콘이 돼요.',
  },
  {
    'w1': 'tomato', 'w2': 'water',
    'result': {'id': 'tomato_soup', 'text': '토마토 수프', 'emoji': '🍅', 'category': 'food', 'level': 2},
    'desc': '토마토를 물과 함께 끓이면 토마토 수프를 만들 수 있어요.',
  },
  {
    'w1': 'tomato', 'w2': 'salt',
    'result': {'id': 'tomato_sauce', 'text': '토마토 소스', 'emoji': '🥫', 'category': 'food', 'level': 2},
    'desc': '토마토에 소금을 넣고 졸이면 맛있는 소스가 돼요.',
  },
  {
    'w1': 'yeast', 'w2': 'dough',
    'result': {'id': 'risen_dough', 'text': '부푼 반죽', 'emoji': '🥣', 'category': 'food', 'level': 3},
    'desc': '효모는 반죽 속에서 기체를 만들어 반죽을 부풀게 해요.',
  },
  {
    'w1': 'risen_dough', 'w2': 'fire',
    'result': {'id': 'soft_bread', 'text': '폭신한 빵', 'emoji': '🍞', 'category': 'food', 'level': 3},
    'desc': '부푼 반죽을 구우면 폭신한 빵이 돼요.',
  },
  {
    'w1': 'seaweed', 'w2': 'cooked_rice',
    'result': {'id': 'kimbap', 'text': '김밥', 'emoji': '🍙', 'category': 'food', 'level': 3},
    'desc': '밥을 김으로 감싸면 김밥을 만들 수 있어요.',
  },
  {
    'w1': 'vinegar', 'w2': 'vegetable',
    'result': {'id': 'pickle', 'text': '피클', 'emoji': '🥒', 'category': 'food', 'level': 2},
    'desc': '채소를 식초에 절이면 새콤한 피클이 돼요.',
  },
  {
    'w1': 'honey_base', 'w2': 'milk',
    'result': {'id': 'honey_milk', 'text': '꿀우유', 'emoji': '🥛', 'category': 'food', 'level': 2},
    'desc': '우유에 꿀을 섞으면 달콤한 꿀우유가 돼요.',
  },
  {
    'w1': 'oil', 'w2': 'egg',
    'result': {'id': 'mayonnaise_base', 'text': '마요네즈 재료', 'emoji': '🥚', 'category': 'food', 'level': 2},
    'desc': '달걀과 기름은 마요네즈를 만드는 기본 재료예요.',
  },
  {
    'w1': 'mayonnaise_base', 'w2': 'vinegar',
    'result': {'id': 'mayonnaise', 'text': '마요네즈', 'emoji': '🥚', 'category': 'food', 'level': 3},
    'desc': '달걀, 기름, 식초를 잘 섞으면 마요네즈가 돼요.',
  },
  {
    'w1': 'flour', 'w2': 'egg',
    'result': {'id': 'batter', 'text': '튀김옷', 'emoji': '🥣', 'category': 'food', 'level': 2},
    'desc': '밀가루와 달걀을 섞으면 음식에 입히는 튀김옷을 만들 수 있어요.',
  },
  {
    'w1': 'batter', 'w2': 'oil',
    'result': {'id': 'fried_batter', 'text': '튀김', 'emoji': '🍤', 'category': 'food', 'level': 3},
    'desc': '튀김옷을 입힌 재료를 기름에 익히면 바삭한 튀김이 돼요.',
  },
  {
    'w1': 'grape', 'w2': 'sugar',
    'result': {'id': 'grape_jam', 'text': '포도잼', 'emoji': '🍇', 'category': 'food', 'level': 2},
    'desc': '포도에 설탕을 넣고 졸이면 포도잼을 만들 수 있어요.',
  },
];
