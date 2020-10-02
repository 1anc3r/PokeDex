import 'package:pokemon/dao/poke_dao.dart';
import 'package:pokemon/models/poke_model.dart';

class PokeModule {
  Map<String, List<PokeModel>> pokes = {};

  factory PokeModule() => _getInstance();
  static PokeModule get instance => _getInstance();
  static PokeModule _instance;
  PokeModule._internal() {
    // 初始化
  }
  static PokeModule _getInstance() {
    if (_instance == null) {
      _instance = new PokeModule._internal();
    }
    return _instance;
  }

  static Map<String, List<PokeModel>> bindList(
      Map<String, List<PokeModel>> newpokes) {
    return instance.pokes = newpokes;
  }

  static PokeModel bindItem(PokeModel newpoke) {
    return newpoke;
  }

  static Future<Map<String, List<PokeModel>>> fetchList() async {
    return PokeDao.fetchPokeList()
        .then((listText) => PokeDao.parsePokeList(listText))
        .then((listData) => bindList(listData));
  }

  static Future<PokeModel> fetchItem(String name) async {
    return PokeDao.fetchPokeItem(name)
        .then((itemText) => PokeDao.parsePokeItem(itemText))
        .then((itemData) => bindItem(itemData));
  }

  static Future fetchItemHQImg(PokeModel model) async {
    return PokeDao.fetchPokeHQImg(model.ndex, model.enname)
        .then((hqImg) => {model.hqImg = hqImg});
  }
}
