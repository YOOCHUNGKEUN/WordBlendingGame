const List<Map<String, dynamic>> plantCombinations = [
  {
    'w1': 'seed', 'w2': 'water',
    'result': {'id': 'sprout', 'text': '새싹', 'emoji': '🌱', 'category': 'nature', 'level': 2},
    'desc': '씨앗은 물을 흡수하면 싹을 틔울 준비를 해요.',
  },
  {
    'w1': 'seed', 'w2': 'earth',
    'result': {'id': 'sprout', 'text': '새싹', 'emoji': '🌱', 'category': 'nature', 'level': 2},
    'desc': '씨앗을 흙에 심고 물을 주면 새싹이 자랄 수 있어요.',
  },
  {
    'w1': 'sprout', 'w2': 'sun',
    'result': {'id': 'plant', 'text': '식물', 'emoji': '🪴', 'category': 'nature', 'level': 3},
    'desc': '새싹은 햇빛을 받아 광합성을 하며 식물로 자라요.',
  },
  {
    'w1': 'sprout', 'w2': 'water',
    'result': {'id': 'flower', 'text': '꽃', 'emoji': '🌸', 'category': 'nature', 'level': 1},
    'desc': '새싹이 물과 영양분을 얻어 자라면 꽃을 피울 수 있어요.',
  },
  {
    'w1': 'plant', 'w2': 'sun',
    'result': {'id': 'oxygen', 'text': '산소', 'emoji': '💚', 'category': 'nature', 'level': 3},
    'desc': '식물은 햇빛으로 광합성을 하며 산소를 내보내요.',
  },
  {
    'w1': 'flower', 'w2': 'wind',
    'result': {'id': 'pollen', 'text': '꽃가루', 'emoji': '🌼', 'category': 'nature', 'level': 2},
    'desc': '바람은 꽃가루를 다른 꽃으로 옮기는 데 도움을 줄 수 있어요.',
  },
  {
    'w1': 'flower', 'w2': 'pollen',
    'result': {'id': 'fruit', 'text': '과일', 'emoji': '🍎', 'category': 'food', 'level': 1},
    'desc': '꽃가루받이가 된 꽃은 시간이 지나 과일을 만들 수 있어요.',
  },
  {
    'w1': 'tree', 'w2': 'wind',
    'result': {'id': 'leaf', 'text': '낙엽', 'emoji': '🍂', 'category': 'nature', 'level': 2},
    'desc': '바람이 불면 오래된 잎이 떨어져 낙엽이 될 수 있어요.',
  },
  {
    'w1': 'tree', 'w2': 'rain',
    'result': {'id': 'mushroom', 'text': '버섯', 'emoji': '🍄', 'category': 'food', 'level': 2},
    'desc': '비가 온 뒤 습한 나무 주변에는 버섯이 자라기 쉬워요.',
  },
  {
    'w1': 'tree', 'w2': 'bird',
    'result': {'id': 'nest', 'text': '새집', 'emoji': '🪹', 'category': 'object', 'level': 2},
    'desc': '새는 나뭇가지와 풀을 모아 둥지를 만들어요.',
  },
];
