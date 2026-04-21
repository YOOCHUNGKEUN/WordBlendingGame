const List<Map<String, dynamic>> natureCombinations = [
  {
    'w1': 'fire', 'w2': 'water',
    'result': {'id': 'steam', 'text': '수증기', 'emoji': '💨', 'category': 'weather', 'level': 2},
    'desc': '불로 물을 끓이면 수증기가 돼요! (물의 상태 변화)',
  },
  {
    'w1': 'water', 'w2': 'earth',
    'result': {'id': 'mud', 'text': '진흙', 'emoji': '🟫', 'category': 'nature', 'level': 2},
    'desc': '물과 흙이 만나면 진흙이 돼요!',
  },
  {
    'w1': 'water', 'w2': 'wind',
    'result': {'id': 'wave', 'text': '파도', 'emoji': '🌊', 'category': 'nature', 'level': 2},
    'desc': '바람이 물 위를 불면 파도가 생겨요!',
  },
  {
    'w1': 'fire', 'w2': 'earth',
    'result': {'id': 'lava', 'text': '용암', 'emoji': '🌋', 'category': 'nature', 'level': 2},
    'desc': '땅속 깊은 곳에서 불과 흙이 만나 용암이 돼요!',
  },
  {
    'w1': 'water', 'w2': 'snow',
    'result': {'id': 'ice', 'text': '얼음', 'emoji': '🧊', 'category': 'nature', 'level': 2},
    'desc': '물이 차가워지면 얼음이 돼요! (물의 상태 변화)',
  },
  {
    'w1': 'fire', 'w2': 'wind',
    'result': {'id': 'wildfire', 'text': '산불', 'emoji': '🔥', 'category': 'nature', 'level': 2},
    'desc': '바람이 불을 더 크게 만들어요! 불조심!',
  },
  {
    'w1': 'fire', 'w2': 'stone',
    'result': {'id': 'magma', 'text': '마그마', 'emoji': '🌋', 'category': 'nature', 'level': 2},
    'desc': '돌이 엄청난 열을 받으면 마그마가 돼요!',
  },
  {
    'w1': 'water', 'w2': 'stone',
    'result': {'id': 'river', 'text': '강', 'emoji': '🏞️', 'category': 'nature', 'level': 2},
    'desc': '물이 돌 사이를 흐르면 강이 돼요!',
  },
  {
    'w1': 'earth', 'w2': 'stone',
    'result': {'id': 'mountain', 'text': '산', 'emoji': '⛰️', 'category': 'nature', 'level': 2},
    'desc': '흙과 돌이 높이 쌓이면 산이 돼요!',
  },
  {
    'w1': 'earth', 'w2': 'wind',
    'result': {'id': 'dust', 'text': '먼지', 'emoji': '💨', 'category': 'nature', 'level': 2},
    'desc': '바람이 흙을 날리면 먼지가 돼요!',
  },
  {
    'w1': 'earth', 'w2': 'seed',
    'result': {'id': 'sprout', 'text': '새싹', 'emoji': '🌱', 'category': 'nature', 'level': 2},
    'desc': '씨앗을 흙에 심으면 새싹이 돼요!',
  },
  {
    'w1': 'fire', 'w2': 'sun',
    'result': {'id': 'heat', 'text': '열기', 'emoji': '🌡️', 'category': 'nature', 'level': 2},
    'desc': '불과 해가 만나면 뜨거운 열기가 돼요!',
  },
  {
    'w1': 'water', 'w2': 'sun',
    'result': {'id': 'rainbow', 'text': '무지개', 'emoji': '🌈', 'category': 'nature', 'level': 2},
    'desc': '물방울에 햇빛이 비치면 무지개가 생겨요!',
  },
  {
    'w1': 'stone', 'w2': 'wind',
    'result': {'id': 'sand', 'text': '모래', 'emoji': '🏖️', 'category': 'nature', 'level': 2},
    'desc': '바람이 돌을 오랫동안 깎으면 모래가 돼요!',
  },
  {
    'w1': 'stone', 'w2': 'fire',
    'result': {'id': 'coal', 'text': '석탄', 'emoji': '⬛', 'category': 'nature', 'level': 2},
    'desc': '땅속 돌이 오랜 시간 열을 받으면 석탄이 돼요!',
  },
  {
    'w1': 'sun', 'w2': 'wind',
    'result': {'id': 'weather', 'text': '날씨', 'emoji': '🌤️', 'category': 'weather', 'level': 2},
    'desc': '해와 바람이 만나서 날씨를 만들어요!',
  },
  {
    'w1': 'sun', 'w2': 'earth',
    'result': {'id': 'desert', 'text': '사막', 'emoji': '🏜️', 'category': 'nature', 'level': 2},
    'desc': '해가 강하게 내리쬐는 땅이 사막이에요!',
  },
  {
    'w1': 'water', 'w2': 'flower',
    'result': {'id': 'lotus', 'text': '연꽃', 'emoji': '🪷', 'category': 'nature', 'level': 2},
    'desc': '물 위에 피는 꽃이 연꽃이에요!',
  },
  {
    'w1': 'earth', 'w2': 'flower',
    'result': {'id': 'garden', 'text': '정원', 'emoji': '🌺', 'category': 'nature', 'level': 2},
    'desc': '흙에 꽃을 심으면 예쁜 정원이 돼요!',
  },
  {
    'w1': 'sun', 'w2': 'flower',
    'result': {'id': 'sunflower', 'text': '해바라기', 'emoji': '🌻', 'category': 'nature', 'level': 2},
    'desc': '해를 바라보는 꽃이 해바라기예요!',
  },
  {
    'w1': 'wind', 'w2': 'flower',
    'result': {'id': 'pollen', 'text': '꽃가루', 'emoji': '🌼', 'category': 'nature', 'level': 2},
    'desc': '바람이 꽃가루를 날려요!',
  },
  {
    'w1': 'fire', 'w2': 'flower',
    'result': {'id': 'ash', 'text': '재', 'emoji': '🌫️', 'category': 'nature', 'level': 2},
    'desc': '꽃이 불에 타면 재가 돼요!',
  },
  {
    'w1': 'snow', 'w2': 'sun',
    'result': {'id': 'water', 'text': '물', 'emoji': '💧', 'category': 'nature', 'level': 1},
    'desc': '눈이 햇빛을 받으면 녹아서 물이 돼요!',
  },
  {
    'w1': 'snow', 'w2': 'earth',
    'result': {'id': 'frozen_ground', 'text': '설원', 'emoji': '🌨️', 'category': 'nature', 'level': 2},
    'desc': '눈이 땅을 덮으면 설원이 돼요!',
  },
  {
    'w1': 'seed', 'w2': 'sun',
    'result': {'id': 'sprout', 'text': '새싹', 'emoji': '🌱', 'category': 'nature', 'level': 2},
    'desc': '씨앗이 햇빛을 받으면 새싹이 나요!',
  },
  {
    'w1': 'seed', 'w2': 'water',
    'result': {'id': 'sprout', 'text': '새싹', 'emoji': '🌱', 'category': 'nature', 'level': 2},
    'desc': '씨앗에 물을 주면 새싹이 나요!',
  },
  {
    'w1': 'tree', 'w2': 'water',
    'result': {'id': 'willow', 'text': '버드나무', 'emoji': '🌿', 'category': 'nature', 'level': 2},
    'desc': '물가에 자라는 나무가 버드나무예요!',
  },
  {
    'w1': 'tree', 'w2': 'wind',
    'result': {'id': 'leaf', 'text': '낙엽', 'emoji': '🍂', 'category': 'nature', 'level': 2},
    'desc': '바람이 불면 나뭇잎이 떨어져요!',
  },
  {
    'w1': 'tree', 'w2': 'sun',
    'result': {'id': 'oxygen', 'text': '산소', 'emoji': '💚', 'category': 'nature', 'level': 2},
    'desc': '나무가 햇빛을 받아 산소를 만들어요! (광합성)',
  },
  {
    'w1': 'tree', 'w2': 'snow',
    'result': {'id': 'pine', 'text': '소나무', 'emoji': '🌲', 'category': 'nature', 'level': 2},
    'desc': '눈 속에서도 초록색인 나무가 소나무예요!',
  },
  {
    'w1': 'tree', 'w2': 'stone',
    'result': {'id': 'forest', 'text': '숲', 'emoji': '🌳', 'category': 'nature', 'level': 2},
    'desc': '나무와 돌이 모여 숲이 돼요!',
  },
];