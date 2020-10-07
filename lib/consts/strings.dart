class STRINGS {
  static const String NORMAL = '一般';
  static const String FIGHTING = '格斗';
  static const String FLYING = '飞行';
  static const String POISON = '毒';
  static const String GROUND = '地面';
  static const String ROCKT = '岩石';
  static const String BUG = '虫';
  static const String GHOST = '幽灵';
  static const String STEEL = '钢';
  static const String FIRE = '火';
  static const String WATER = '水';
  static const String GRASS = '草';
  static const String ELECTRIC = '电';
  static const String PSYCHIC = '超能力';
  static const String ICE = '冰';
  static const String DRAGON = '龙';
  static const String DARK = '恶';
  static const String FAIRY = '妖精';
  static const String MALE = '雄性';
  static const String FEMALE = '雌性';

  static const String HP = '生命';
  static const String ATK = '攻击';
  static const String DEF = '防御';
  static const String SAT = '特攻';
  static const String SDE = '特防';
  static const String SPD = '速度';
  static const String TOTAL = '总和';

  static const Map<String, String> GAME_GEN_MAP = {
    '第一世代': '第一世代\n关都地区',
    '第二世代': '第二世代\n城都地区',
    '第三世代': '第三世代\n丰缘地区',
    '第四世代': '第四世代\n神奥地区',
    '第五世代': '第五世代\n合众地区',
    '第六世代': '第六世代\n卡洛斯地区',
    '第七世代': '第七世代\n阿罗拉地区',
    '第八世代': '第八世代\n伽勒尔地区',
  };

  static const List<String> CHAR_LIST = const [
    '0, 5, 10, 15, 20, 25, 30',
    '1, 6, 11, 16, 21, 26, 31',
    '2, 7, 12, 17, 22, 27',
    '3, 8, 13, 18, 23, 28',
    '4, 9, 14, 19, 24, 29',
  ];

  static const List<List<String>> CHAR_TABLE = const [
    [
      '非常喜欢吃东西\nたべるのがだいすき\nLoves to eat',
      '以力气大为傲\nちからがじまん\nProud of its power',
      '身体强壮\nからだがじょうぶ\nSturdy body',
      '好奇心强\nこうきしんがつよい\nHighly curious',
      '性格强势\nきがつよい\nStrong willed',
      '喜欢比谁跑得快\nかけっこがすき\nLikes to run'
    ],
    [
      '经常睡午觉\nひるねをよくする\nTakes plenty of siestas',
      '喜欢胡闹\nあばれることがすき\nLikes to thrash about',
      '抗打能力强\nうたれづよい\nCapable of taking hits',
      '喜欢恶作剧\nイタズラがすき\nMischievous',
      '有一点点爱慕虚荣\nちょっぴりみえっぱり\nSomewhat vain',
      '对声音敏感\nものおとにびんかん\nAlert to sounds'
    ],
    [
      '常常打瞌睡\nいねむりがおおい\nNods off a lot',
      '有点容易生气\nちょっとおこりっぽい\nA little quick tempered',
      '顽强不屈\nねばりづよい\nHighly persistent',
      '做事万无一失\nぬけめがない\nThoroughly cunning',
      '争强好胜\nまけんきがつよい\nStrongly defiant',
      '冒冒失失\nおっちょこちょい\nImpetuous and silly'
    ],
    [
      '经常乱扔东西\nものをよくちらかす\nScatters things often',
      '喜欢打架\nケンカをするのがすき\nLikes to fight',
      '能吃苦耐劳\nしんぼうづよい\nGood endurance',
      '经常思考\nかんがえごとがおおい\nOften lost in thought',
      '不服输\nまけずぎらい\nHates to lose',
      '有点容易得意忘形\nすこしおちょうしもの\nSomewhat of a clown'
    ],
    [
      '喜欢悠然自在\nのんびりするのがすき\nLikes to relax',
      '血气方刚\nちのけがおおい\nQuick tempered',
      '善于忍耐\nがまんづよい\nGood perseverance',
      '一丝不苟\nとてもきちょうめん\nVery finicky',
      '有一点点固执\nちょっぴりごうじょう\nSomewhat stubborn',
      '逃得快\nにげるのがはやい\nQuick to flee'
    ],
  ];

  static const NATURE_TABLE = const [
    ['勤奋\nがんばりや\nHardy', '—', '—', '—', '—'],
    ['怕寂寞\nさみしがり\nLonely', '攻击', '防御', '辣', '酸'],
    ['固执\nいじっぱり\nAdamant', '攻击', '特攻', '辣', '涩'],
    ['顽皮\nやんちゃ\nNaughty', '攻击', '特防', '辣', '苦'],
    ['勇敢\nゆうかん\nBrave', '攻击', '速度', '辣', '甜'],
    ['大胆\nずぶとい\nBold', '防御', '攻击', '酸', '辣'],
    ['坦率\nすなお\nDocile', '—', '—', '—', '—'],
    ['淘气\nわんぱく\nImpish', '防御', '特攻', '酸', '涩'],
    ['乐天\nのうてんき\nLax', '防御', '特防', '酸', '苦'],
    ['悠闲\nのんき\nRelaxed', '防御', '速度', '酸', '甜'],
    ['内敛\nひかえめ\nModest', '特攻', '攻击', '涩', '辣'],
    ['慢吞吞\nおっとり\nMild', '特攻', '防御', '涩', '酸'],
    ['害羞\nてれや\nBashful', '—', '—', '—', '—'],
    ['马虎\nうっかりや\nRash', '特攻', '特防', '涩', '苦'],
    ['冷静\nれいせい\nQuiet', '特攻', '速度', '涩', '甜'],
    ['温和\nおだやか\nCalm', '特防', '攻击', '苦', '辣'],
    ['温顺\nおとなしい\nGentle', '特防', '防御', '苦', '酸'],
    ['慎重\nしんちょう\nCareful', '特防', '特攻', '苦', '涩'],
    ['浮躁\nきまぐれ\nQuirky', '—', '—', '—', '—'],
    ['自大\nなまいき\nSassy', '特防', '速度', '苦', '甜'],
    ['胆小\nおくびょう\nTimid', '速度', '攻击', '甜', '辣'],
    ['急躁\nせっかち\nHasty', '速度', '防御', '甜', '酸'],
    ['爽朗\nようき\nJolly', '速度', '特攻', '甜', '涩'],
    ['天真\nむじゃき\nNaive', '速度', '特防', '甜', '苦'],
    ['认真\nまじめ\nSerious', '—', '—', '—', '—'],
  ];
}
