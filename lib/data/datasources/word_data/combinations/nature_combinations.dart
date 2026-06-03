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
  {
    'w1': 'air', 'w2': 'water',
    'result': {'id': 'moist_air', 'text': '습한 공기', 'emoji': '💦', 'category': 'weather', 'level': 2},
    'desc': '공기 속에 물방울이나 수증기가 많아지면 습한 공기가 돼요.',
  },
  {
    'w1': 'air', 'w2': 'dust',
    'result': {'id': 'haze', 'text': '먼지 낀 공기', 'emoji': '🌫️', 'category': 'weather', 'level': 3},
    'desc': '공기 중에 먼지가 많이 떠 있으면 시야가 뿌옇게 보여요.',
  },
  {
    'w1': 'clay', 'w2': 'water',
    'result': {'id': 'soft_clay', 'text': '말랑한 찰흙', 'emoji': '🟫', 'category': 'nature', 'level': 2},
    'desc': '찰흙에 물을 더하면 모양을 만들기 쉬운 말랑한 찰흙이 돼요.',
  },
  {
    'w1': 'clay', 'w2': 'fire',
    'result': {'id': 'baked_clay', 'text': '구운 흙', 'emoji': '🧱', 'category': 'object', 'level': 2},
    'desc': '찰흙을 뜨겁게 구우면 단단하게 굳어요.',
  },
  {
    'w1': 'sand_base', 'w2': 'wind',
    'result': {'id': 'dune', 'text': '모래 언덕', 'emoji': '🏜️', 'category': 'nature', 'level': 2},
    'desc': '바람이 모래를 한곳에 쌓으면 모래 언덕이 생겨요.',
  },
  {
    'w1': 'sand_base', 'w2': 'water',
    'result': {'id': 'wet_sand', 'text': '젖은 모래', 'emoji': '🏖️', 'category': 'nature', 'level': 2},
    'desc': '모래에 물이 스며들면 뭉치기 쉬운 젖은 모래가 돼요.',
  },
  {
    'w1': 'root_base', 'w2': 'earth',
    'result': {'id': 'anchored_root', 'text': '박힌 뿌리', 'emoji': '🌱', 'category': 'nature', 'level': 2},
    'desc': '뿌리는 흙 속으로 자라 식물을 단단히 붙잡아 줘요.',
  },
  {
    'w1': 'leaf_base', 'w2': 'water',
    'result': {'id': 'transpiration', 'text': '증산', 'emoji': '💧', 'category': 'nature', 'level': 2},
    'desc': '잎은 작은 구멍으로 물을 수증기처럼 내보내요. 이것을 증산이라고 해요.',
  },
  {
    'w1': 'leaf_base', 'w2': 'sunlight',
    'result': {'id': 'chlorophyll', 'text': '초록 잎', 'emoji': '🍃', 'category': 'nature', 'level': 2},
    'desc': '잎 속의 초록 색소는 햇빛을 받아 양분을 만드는 데 도움을 줘요.',
  },
  {
    'w1': 'compost', 'w2': 'earth',
    'result': {'id': 'rich_soil', 'text': '영양 흙', 'emoji': '🌱', 'category': 'nature', 'level': 2},
    'desc': '퇴비가 흙에 섞이면 식물이 자라기 좋은 영양 흙이 돼요.',
  },
  {
    'w1': 'metal_ore', 'w2': 'fire',
    'result': {'id': 'metal', 'text': '금속', 'emoji': '⚙️', 'category': 'object', 'level': 2},
    'desc': '광석을 높은 열로 처리하면 금속을 얻을 수 있어요.',
  },
  {
    'w1': 'metal_ore', 'w2': 'stone',
    'result': {'id': 'ore_vein', 'text': '광맥', 'emoji': '⛏️', 'category': 'nature', 'level': 2},
    'desc': '암석 사이에 광석이 이어져 있으면 광맥이라고 해요.',
  },
  {
    'w1': 'moss', 'w2': 'water',
    'result': {'id': 'wet_moss', 'text': '젖은 이끼', 'emoji': '🌿', 'category': 'nature', 'level': 2},
    'desc': '이끼는 습한 곳에서 물을 머금고 잘 자라요.',
  },
  {
    'w1': 'moss', 'w2': 'stone',
    'result': {'id': 'mossy_stone', 'text': '이끼 낀 돌', 'emoji': '🪨', 'category': 'nature', 'level': 2},
    'desc': '습한 돌 표면에는 이끼가 붙어 자랄 수 있어요.',
  },
  {
    'w1': 'branch', 'w2': 'fire',
    'result': {'id': 'campfire', 'text': '모닥불', 'emoji': '🔥', 'category': 'nature', 'level': 2},
    'desc': '마른 가지에 불이 붙으면 모닥불을 만들 수 있어요.',
  },
];
