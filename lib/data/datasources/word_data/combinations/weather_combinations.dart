const List<Map<String, dynamic>> weatherCombinations = [
  {
    'w1': 'water', 'w2': 'cloud',
    'result': {'id': 'rain', 'text': '비', 'emoji': '🌧️', 'category': 'weather', 'level': 1},
    'desc': '구름 속 물방울이 무거워지면 비가 내려요!',
  },
  {
    'w1': 'cloud', 'w2': 'wind',
    'result': {'id': 'storm', 'text': '폭풍', 'emoji': '⛈️', 'category': 'weather', 'level': 2},
    'desc': '구름과 바람이 세게 만나면 폭풍이 돼요!',
  },
  {
    'w1': 'rain', 'w2': 'sun',
    'result': {'id': 'rainbow', 'text': '무지개', 'emoji': '🌈', 'category': 'nature', 'level': 2},
    'desc': '비가 온 뒤 햇빛이 나면 무지개가 생겨요!',
  },
  {
    'w1': 'snow', 'w2': 'wind',
    'result': {'id': 'blizzard', 'text': '눈보라', 'emoji': '🌨️', 'category': 'weather', 'level': 2},
    'desc': '눈과 바람이 만나면 눈보라가 돼요!',
  },
  {
    'w1': 'wave', 'w2': 'wind',
    'result': {'id': 'storm', 'text': '폭풍', 'emoji': '⛈️', 'category': 'weather', 'level': 2},
    'desc': '파도와 바람이 만나면 폭풍이 돼요!',
  },
  {
    'w1': 'cloud', 'w2': 'sun',
    'result': {'id': 'cloudy', 'text': '흐림', 'emoji': '⛅', 'category': 'weather', 'level': 2},
    'desc': '구름이 해를 가리면 날씨가 흐려요!',
  },
  {
    'w1': 'cloud', 'w2': 'snow',
    'result': {'id': 'blizzard', 'text': '눈보라', 'emoji': '🌨️', 'category': 'weather', 'level': 2},
    'desc': '구름에서 눈이 내리면 눈보라가 돼요!',
  },
  {
    'w1': 'rain', 'w2': 'wind',
    'result': {'id': 'typhoon', 'text': '태풍', 'emoji': '🌀', 'category': 'weather', 'level': 2},
    'desc': '비와 바람이 함께 몰아치면 태풍이 돼요!',
  },
  {
    'w1': 'cloud', 'w2': 'earth',
    'result': {'id': 'fog', 'text': '안개', 'emoji': '🌫️', 'category': 'weather', 'level': 2},
    'desc': '구름이 땅 위에 내려오면 안개가 돼요!',
  },
  {
    'w1': 'rain', 'w2': 'cold',
    'result': {'id': 'snow', 'text': '눈', 'emoji': '❄️', 'category': 'weather', 'level': 1},
    'desc': '날씨가 추울 때 비가 내리면 눈이 돼요!',
  },
  {
    'w1': 'cloud', 'w2': 'fire',
    'result': {'id': 'thunder', 'text': '천둥', 'emoji': '⚡', 'category': 'weather', 'level': 2},
    'desc': '구름 속 전기가 불처럼 터지면 천둥이 쳐요!',
  },
  {
    'w1': 'rain', 'w2': 'earth',
    'result': {'id': 'mud', 'text': '진흙', 'emoji': '🟫', 'category': 'nature', 'level': 2},
    'desc': '비가 내려 흙이 젖으면 진흙이 돼요!',
  },
  {
    'w1': 'snow', 'w2': 'stone',
    'result': {'id': 'glacier', 'text': '빙하', 'emoji': '🧊', 'category': 'nature', 'level': 2},
    'desc': '눈이 돌처럼 단단하게 굳으면 빙하가 돼요!',
  },
  {
    'w1': 'wind', 'w2': 'sun',
    'result': {'id': 'dry', 'text': '건조', 'emoji': '🌵', 'category': 'weather', 'level': 2},
    'desc': '바람과 햇빛이 함께하면 건조해져요!',
  },
];