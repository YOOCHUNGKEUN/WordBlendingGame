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
];
