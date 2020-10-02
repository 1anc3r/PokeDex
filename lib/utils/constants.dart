import 'dart:ui';

class Constants {
  static const double RADICAL_THREE = 1.7320508;
  static const double PI = 3.1415926;

  static const String POKE_TYPE_ICON_PRE_URL = 'assets/icons/20px-LPLE_';
  static const String POKE_LQ_IMG_URL =
      'https://play.pokemonshowdown.com/sprites/gen5/';
  static const String POKE_WIKI = 'https://wiki.52poke.com/';
  static const String POKE_HQ_IMG_URL = '${POKE_WIKI}/wiki/File:';
  static const String POKE_INDEX_URL = '${POKE_WIKI}/index.php';
  static const String POKE_CN_LIST_URL =
      '?title=%E5%AE%9D%E5%8F%AF%E6%A2%A6%E5%88%97%E8%A1%A8%EF%BC%88%E6%8C%89%E5%85%A8%E5%9B%BD%E5%9B%BE%E9%89%B4%E7%BC%96%E5%8F%B7%EF%BC%89/%E7%AE%80%E5%8D%95%E7%89%88&action=edit';

  static const String HP = '生命';
  static const String ATK = '攻击';
  static const String DEF = '防御';
  static const String SAT = '特攻';
  static const String SDE = '特防';
  static const String SPD = '速度';

  static const Map<String, Color> POKE_COLOR_MAP = {
    '一般': Color(0xFF9199A1),
    '格斗': Color(0xFFCD406A),
    '飞行': Color(0xFF8EA8DE),
    '毒': Color(0xFFA96AC8),
    '地面': Color(0xFFD87844),
    '岩石': Color(0xFFC5B78B),
    '虫': Color(0xFF91C02E),
    '幽灵': Color(0xFF5269AC),
    '钢': Color(0xFF5A8DA1),
    '火': Color(0xFFFE9C54),
    '水': Color(0xFF4F90D5),
    '草': Color(0xFF62BB5A),
    '电': Color(0xFFF4D23C),
    '超能力': Color(0xFFF97178),
    '冰': Color(0xFF73CEBF),
    '龙': Color(0xFF44685E),
    '恶': Color(0xFF5A5365),
    '妖精': Color(0xFFEB8FE6),
    '雄性': Color(0xFF3355FF),
    '雌性': Color(0xFFFF77DD),
    HP: Color(0xFF8AC654),
    ATK: Color(0xFFF8CB3C),
    DEF: Color(0xFFD98837),
    SAT: Color(0xFF59C3D0),
    SDE: Color(0xFF5890CD),
    SPD: Color(0xFFA456D0),
  };

  static const Map<int, double> POKE_GENDER_CODE_MAP = {
    256: -2.0,
    255: -1.0,
    254: 0.0,
    223: .125,
    191: .25,
    127: .50,
    63: .75,
    31: .875,
    0: 1.0,
  };
}
