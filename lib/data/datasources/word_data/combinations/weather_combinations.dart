const List<Map<String, dynamic>> weatherCombinations = [
  {
    'w1': 'water', 'w2': 'cloud',
    'result': {'id': 'rain', 'text': '비', 'emoji': '🌧️', 'category': 'weather', 'level': 1},
    'desc': '구름 속 물방울이 커지고 무거워지면 비로 떨어져요.',
  },
  {
    'w1': 'rain', 'w2': 'sun',
    'result': {'id': 'rainbow', 'text': '무지개', 'emoji': '🌈', 'category': 'weather', 'level': 2},
    'desc': '비가 온 뒤 물방울에 햇빛이 꺾여 들어가면 무지개가 보여요.',
  },
  {
    'w1': 'steam', 'w2': 'wind',
    'result': {'id': 'fog', 'text': '안개', 'emoji': '🌫️', 'category': 'weather', 'level': 3},
    'desc': '공기 중 수증기가 식어 작은 물방울이 되면 안개처럼 보여요.',
  },
  {
    'w1': 'cloud', 'w2': 'wind',
    'result': {'id': 'storm', 'text': '폭풍', 'emoji': '⛈️', 'category': 'weather', 'level': 2},
    'desc': '강한 바람과 큰 구름이 만나면 폭풍 날씨가 될 수 있어요.',
  },
  {
    'w1': 'snow', 'w2': 'wind',
    'result': {'id': 'blizzard', 'text': '눈보라', 'emoji': '🌨️', 'category': 'weather', 'level': 2},
    'desc': '눈이 내릴 때 바람이 세게 불면 눈보라가 돼요.',
  },
  {
    'w1': 'rain', 'w2': 'wind',
    'result': {'id': 'rainstorm', 'text': '비바람', 'emoji': '🌧️', 'category': 'weather', 'level': 2},
    'desc': '비와 바람이 함께 강해지면 비바람이 몰아쳐요.',
  },
  {
    'w1': 'cloud', 'w2': 'lightning',
    'result': {'id': 'thunderstorm', 'text': '뇌우', 'emoji': '⛈️', 'category': 'weather', 'level': 2},
    'desc': '먹구름 속 전기가 번개로 나타나고 천둥이 들리면 뇌우예요.',
  },
  {
    'w1': 'rain', 'w2': 'frost',
    'result': {'id': 'hail', 'text': '우박', 'emoji': '🌨️', 'category': 'weather', 'level': 2},
    'desc': '구름 속 물방울이 얼었다 녹기를 반복하면 우박이 될 수 있어요.',
  },
  {
    'w1': 'snow', 'w2': 'stone',
    'result': {'id': 'glacier', 'text': '빙하', 'emoji': '🧊', 'category': 'nature', 'level': 2},
    'desc': '눈이 오래 쌓이고 눌려 단단한 얼음 덩어리가 되면 빙하가 돼요.',
  },
  {
    'w1': 'cloud', 'w2': 'sun',
    'result': {'id': 'cloudy', 'text': '흐림', 'emoji': '⛅', 'category': 'weather', 'level': 2},
    'desc': '구름이 햇빛을 가리면 흐린 날씨가 돼요.',
  },
];
