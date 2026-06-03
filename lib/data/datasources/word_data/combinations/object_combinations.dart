const List<Map<String, dynamic>> objectCombinations = [
  {
    'w1': 'mud', 'w2': 'fire',
    'result': {'id': 'brick', 'text': '벽돌', 'emoji': '🧱', 'category': 'object', 'level': 3},
    'desc': '진흙을 모양내어 굽고 말리면 단단한 벽돌을 만들 수 있어요.',
  },
  {
    'w1': 'brick', 'w2': 'house',
    'result': {'id': 'brick_house', 'text': '벽돌집', 'emoji': '🏠', 'category': 'object', 'level': 3},
    'desc': '벽돌을 쌓아 튼튼한 벽돌집을 지을 수 있어요.',
  },
  {
    'w1': 'tree', 'w2': 'house',
    'result': {'id': 'treehouse', 'text': '나무집', 'emoji': '🏡', 'category': 'object', 'level': 2},
    'desc': '나무 위나 나무 재료로 만든 집을 나무집이라고 해요.',
  },
  {
    'w1': 'stone', 'w2': 'house',
    'result': {'id': 'stone_house', 'text': '돌집', 'emoji': '🏠', 'category': 'object', 'level': 2},
    'desc': '돌을 쌓아 벽을 만들면 튼튼한 돌집을 지을 수 있어요.',
  },
  {
    'w1': 'house', 'w2': 'book',
    'result': {'id': 'library', 'text': '도서관', 'emoji': '📚', 'category': 'object', 'level': 2},
    'desc': '책을 많이 모아 보관하고 읽는 집은 도서관이에요.',
  },
  {
    'w1': 'book', 'w2': 'earth',
    'result': {'id': 'map', 'text': '지도', 'emoji': '🗺️', 'category': 'object', 'level': 2},
    'desc': '땅의 모양과 길을 책이나 종이에 그리면 지도가 돼요.',
  },
  {
    'w1': 'sand', 'w2': 'fire',
    'result': {'id': 'glass', 'text': '유리', 'emoji': '🪟', 'category': 'object', 'level': 3},
    'desc': '모래의 주성분을 아주 높은 온도로 녹이면 유리를 만들 수 있어요.',
  },
  {
    'w1': 'glass', 'w2': 'sun',
    'result': {'id': 'lens', 'text': '렌즈', 'emoji': '🔍', 'category': 'object', 'level': 3},
    'desc': '모양을 낸 유리는 햇빛을 모으거나 물체를 크게 보이게 하는 렌즈가 될 수 있어요.',
  },
  {
    'w1': 'tree', 'w2': 'book',
    'result': {'id': 'paper', 'text': '종이', 'emoji': '📄', 'category': 'object', 'level': 2},
    'desc': '나무 섬유를 잘게 풀어 얇게 펴고 말리면 종이를 만들 수 있어요.',
  },
  {
    'w1': 'paper', 'w2': 'book',
    'result': {'id': 'notebook', 'text': '공책', 'emoji': '📓', 'category': 'object', 'level': 3},
    'desc': '여러 장의 종이를 묶으면 글을 쓰는 공책이 돼요.',
  },
  {
    'w1': 'wind', 'w2': 'house',
    'result': {'id': 'windmill', 'text': '풍차', 'emoji': '🌬️', 'category': 'object', 'level': 2},
    'desc': '바람의 힘으로 날개를 돌리는 장치를 풍차라고 해요.',
  },
  {
    'w1': 'soft_clay', 'w2': 'bowl',
    'result': {'id': 'clay_bowl', 'text': '찰흙 그릇', 'emoji': '🥣', 'category': 'object', 'level': 3},
    'desc': '말랑한 찰흙을 그릇 모양으로 빚으면 찰흙 그릇이 돼요.',
  },
  {
    'w1': 'clay_bowl', 'w2': 'fire',
    'result': {'id': 'pottery', 'text': '도자기', 'emoji': '🏺', 'category': 'object', 'level': 3},
    'desc': '찰흙 그릇을 높은 온도로 구우면 단단한 도자기가 돼요.',
  },
  {
    'w1': 'cup', 'w2': 'water',
    'result': {'id': 'water_cup', 'text': '물컵', 'emoji': '🥤', 'category': 'object', 'level': 2},
    'desc': '컵에 물을 담으면 물컵이 돼요.',
  },
  {
    'w1': 'glass', 'w2': 'cup',
    'result': {'id': 'glass_cup', 'text': '유리컵', 'emoji': '🥛', 'category': 'object', 'level': 3},
    'desc': '유리로 만든 컵은 투명해서 안을 볼 수 있어요.',
  },
  {
    'w1': 'tool', 'w2': 'stone',
    'result': {'id': 'stone_tool', 'text': '돌도구', 'emoji': '🪨', 'category': 'object', 'level': 2},
    'desc': '돌을 다듬으면 자르거나 두드리는 돌도구가 될 수 있어요.',
  },
  {
    'w1': 'tool', 'w2': 'branch',
    'result': {'id': 'wood_tool', 'text': '나무도구', 'emoji': '🛠️', 'category': 'object', 'level': 2},
    'desc': '가지를 다듬으면 간단한 나무도구를 만들 수 있어요.',
  },
  {
    'w1': 'cloth', 'w2': 'water',
    'result': {'id': 'wet_cloth', 'text': '젖은 천', 'emoji': '🧽', 'category': 'object', 'level': 2},
    'desc': '천에 물이 스며들면 젖은 천이 돼요.',
  },
  {
    'w1': 'cloth', 'w2': 'wind',
    'result': {'id': 'dry_cloth', 'text': '마른 천', 'emoji': '🧺', 'category': 'object', 'level': 2},
    'desc': '바람은 젖은 천의 물기를 날려 말리는 데 도움을 줘요.',
  },
  {
    'w1': 'bowl', 'w2': 'water',
    'result': {'id': 'water_bowl', 'text': '물그릇', 'emoji': '🥣', 'category': 'object', 'level': 2},
    'desc': '그릇에 물을 담으면 물그릇이 돼요.',
  },
  {
    'w1': 'magnet', 'w2': 'metal',
    'result': {'id': 'magnetic_metal', 'text': '붙은 금속', 'emoji': '🧲', 'category': 'object', 'level': 3},
    'desc': '자석은 철 같은 금속을 끌어당길 수 있어요.',
  },
  {
    'w1': 'battery', 'w2': 'wire',
    'result': {'id': 'circuit', 'text': '전기 회로', 'emoji': '🔌', 'category': 'object', 'level': 2},
    'desc': '전지와 전선을 이어 전기가 흐르는 길을 만들면 회로가 돼요.',
  },
  {
    'w1': 'circuit', 'w2': 'magnet',
    'result': {'id': 'electromagnet', 'text': '전자석', 'emoji': '🧲', 'category': 'object', 'level': 3},
    'desc': '전기가 흐르는 전선은 자석처럼 금속을 끌어당기는 힘을 만들 수 있어요.',
  },
  {
    'w1': 'metal', 'w2': 'fire',
    'result': {'id': 'hot_metal', 'text': '달군 금속', 'emoji': '🔥', 'category': 'object', 'level': 3},
    'desc': '금속을 불에 달구면 뜨거워지고 모양을 바꾸기 쉬워져요.',
  },
  {
    'w1': 'hot_metal', 'w2': 'tool',
    'result': {'id': 'shaped_metal', 'text': '두드린 금속', 'emoji': '⚙️', 'category': 'object', 'level': 3},
    'desc': '뜨거운 금속을 도구로 두드리면 원하는 모양으로 만들 수 있어요.',
  },
  {
    'w1': 'wool', 'w2': 'cloth',
    'result': {'id': 'wool_cloth', 'text': '양털 천', 'emoji': '🧣', 'category': 'object', 'level': 3},
    'desc': '양털을 실로 만들고 짜면 따뜻한 천을 만들 수 있어요.',
  },
];
