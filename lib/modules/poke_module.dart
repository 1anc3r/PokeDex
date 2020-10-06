import 'package:pokemon/dao/poke_net_dao.dart';
import 'package:pokemon/models/poke_model.dart';

class PokeModule {
  Map<String, List<PokeModel>> pokes = {};

  static PokeNetDao dao = new PokeNetDao();

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

  static Future<Map<String, List<PokeModel>>> fetchList() async {
    return dao
        .fetchPokeList()
        .then((listText) => dao.parsePokeList(listText))
        .then((listData) => bindList(listData));
  }

  static Future<PokeModel> fetchItem(String name) async {
    return dao
        .fetchPokeItem(name)
        .then((itemText) => dao.parsePokeItem(itemText));
  }

  static Future fetchItemHQImg(PokeModel model) async {
    return dao
        .fetchPokeImg(model.ndex, model.enname)
        .then((hqImg) => {model.hqImg = hqImg});
  }
}
