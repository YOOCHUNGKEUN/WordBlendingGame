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
  {
    'w1': 'root_base', 'w2': 'water',
    'result': {'id': 'water_absorption', 'text': '물 흡수', 'emoji': '💧', 'category': 'nature', 'level': 2},
    'desc': '뿌리는 흙 속의 물을 빨아들여 식물에 보내요.',
  },
  {
    'w1': 'root_base', 'w2': 'earth',
    'result': {'id': 'rooted_plant', 'text': '뿌리내린 식물', 'emoji': '🪴', 'category': 'nature', 'level': 2},
    'desc': '뿌리가 흙에 자리 잡으면 식물이 더 안정적으로 자라요.',
  },
  {
    'w1': 'leaf_base', 'w2': 'sunlight',
    'result': {'id': 'photosynthesis', 'text': '광합성', 'emoji': '🔆', 'category': 'nature', 'level': 3},
    'desc': '잎은 햇빛을 이용해 물과 공기 중 이산화탄소로 양분을 만들어요.',
  },
  {
    'w1': 'leaf_base', 'w2': 'air',
    'result': {'id': 'leaf_breathing', 'text': '잎의 숨쉬기', 'emoji': '🍃', 'category': 'nature', 'level': 2},
    'desc': '잎은 공기와 기체를 주고받으며 살아가요.',
  },
  {
    'w1': 'bee', 'w2': 'flower',
    'result': {'id': 'pollination', 'text': '꽃가루받이', 'emoji': '🐝', 'category': 'nature', 'level': 2},
    'desc': '벌이 꽃을 오가며 꽃가루를 옮기면 꽃가루받이가 일어나요.',
  },
  {
    'w1': 'butterfly', 'w2': 'flower',
    'result': {'id': 'butterfly_garden', 'text': '나비 정원', 'emoji': '🦋', 'category': 'nature', 'level': 2},
    'desc': '꽃이 많은 곳에는 꿀을 찾는 나비가 찾아올 수 있어요.',
  },
  {
    'w1': 'compost', 'w2': 'seed',
    'result': {'id': 'healthy_sprout', 'text': '튼튼한 새싹', 'emoji': '🌱', 'category': 'nature', 'level': 2},
    'desc': '영양분이 있는 흙에서는 새싹이 더 튼튼하게 자랄 수 있어요.',
  },
  {
    'w1': 'compost', 'w2': 'plant',
    'result': {'id': 'healthy_plant', 'text': '건강한 식물', 'emoji': '🪴', 'category': 'nature', 'level': 3},
    'desc': '퇴비의 영양분은 식물이 건강하게 자라는 데 도움을 줘요.',
  },
  {
    'w1': 'branch', 'w2': 'leaf_base',
    'result': {'id': 'leafy_branch', 'text': '잎 달린 가지', 'emoji': '🌿', 'category': 'nature', 'level': 2},
    'desc': '가지에 잎이 달리면 햇빛을 더 많이 받을 수 있어요.',
  },
  {
    'w1': 'branch', 'w2': 'flower',
    'result': {'id': 'flowering_branch', 'text': '꽃가지', 'emoji': '🌸', 'category': 'nature', 'level': 2},
    'desc': '가지 끝에 꽃이 피면 꽃가지가 돼요.',
  },
  {
    'w1': 'worm', 'w2': 'compost',
    'result': {'id': 'humus', 'text': '부식토', 'emoji': '🌱', 'category': 'nature', 'level': 2},
    'desc': '지렁이는 낙엽과 퇴비가 흙으로 바뀌는 과정을 도와요.',
  },
  {
    'w1': 'pollination', 'w2': 'flower',
    'result': {'id': 'seed_pod', 'text': '씨앗주머니', 'emoji': '🌱', 'category': 'nature', 'level': 3},
    'desc': '꽃가루받이가 된 꽃은 씨앗을 품는 열매나 씨앗주머니를 만들 수 있어요.',
  },
];
