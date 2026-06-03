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
  {
    'w1': 'humidity', 'w2': 'cold_air',
    'result': {'id': 'condensation', 'text': '응결', 'emoji': '💧', 'category': 'weather', 'level': 2},
    'desc': '습한 공기가 차가워지면 수증기가 작은 물방울로 변해요. (응결)',
  },
  {
    'w1': 'dark_cloud', 'w2': 'wind',
    'result': {'id': 'squall', 'text': '돌풍', 'emoji': '💨', 'category': 'weather', 'level': 2},
    'desc': '먹구름 주변에서는 갑자기 강한 바람이 불 수 있어요.',
  },
  {
    'w1': 'dark_cloud', 'w2': 'lightning',
    'result': {'id': 'lightning_storm', 'text': '번개 폭풍', 'emoji': '⛈️', 'category': 'weather', 'level': 2},
    'desc': '먹구름 속 전기가 강해지면 번개가 치는 폭풍이 될 수 있어요.',
  },
  {
    'w1': 'heat_air', 'w2': 'cold_air',
    'result': {'id': 'weather_front', 'text': '전선', 'emoji': '🌦️', 'category': 'weather', 'level': 2},
    'desc': '더운 공기와 찬 공기가 만나면 날씨가 바뀌는 경계가 생겨요.',
  },
  {
    'w1': 'humidity', 'w2': 'sunlight',
    'result': {'id': 'muggy', 'text': '후텁지근함', 'emoji': '🥵', 'category': 'weather', 'level': 2},
    'desc': '습기가 많고 햇빛이 강하면 후텁지근하게 느껴져요.',
  },
  {
    'w1': 'dew', 'w2': 'frost',
    'result': {'id': 'ice_crystal', 'text': '얼음 결정', 'emoji': '❄️', 'category': 'weather', 'level': 2},
    'desc': '이슬이 아주 차가워지면 작은 얼음 결정이 될 수 있어요.',
  },
  {
    'w1': 'fog', 'w2': 'sun',
    'result': {'id': 'clear_sky', 'text': '맑은 하늘', 'emoji': '☀️', 'category': 'weather', 'level': 2},
    'desc': '햇빛이 공기를 데우면 안개가 흩어져 하늘이 맑아질 수 있어요.',
  },
  {
    'w1': 'hail', 'w2': 'sun',
    'result': {'id': 'meltwater', 'text': '녹은 물', 'emoji': '💧', 'category': 'nature', 'level': 2},
    'desc': '우박은 햇빛과 따뜻한 공기를 만나면 녹아 물이 돼요.',
  },
  {
    'w1': 'cloud', 'w2': 'cold_air',
    'result': {'id': 'snow_cloud', 'text': '눈구름', 'emoji': '🌨️', 'category': 'weather', 'level': 2},
    'desc': '구름 속 물방울이 차가워지면 눈을 만들 수 있는 눈구름이 돼요.',
  },
  {
    'w1': 'wind', 'w2': 'dust',
    'result': {'id': 'dust_storm', 'text': '먼지바람', 'emoji': '🌪️', 'category': 'weather', 'level': 2},
    'desc': '강한 바람이 먼지를 많이 날리면 먼지바람이 생겨요.',
  },
  {
    'w1': 'heat_air', 'w2': 'water',
    'result': {'id': 'warm_water', 'text': '따뜻한 물', 'emoji': '♨️', 'category': 'nature', 'level': 2},
    'desc': '더운 공기나 열은 물의 온도를 높일 수 있어요.',
  },
  {
    'w1': 'cold_air', 'w2': 'water',
    'result': {'id': 'cold_water', 'text': '찬물', 'emoji': '💧', 'category': 'nature', 'level': 2},
    'desc': '찬 공기와 닿은 물은 온도가 내려가 찬물이 돼요.',
  },
];
