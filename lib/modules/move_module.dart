import 'package:pokemon/dao/move_net_dao.dart';
import 'package:pokemon/models/move_model.dart';
import 'package:pokemon/models/poke_model.dart';

class MoveModule {
  Map<String, List<MoveModel>> moves = {};

  static MoveNetDao dao = new MoveNetDao();

  factory MoveModule() => _getInstance();
  static MoveModule get instance => _getInstance();
  static MoveModule _instance;

  MoveModule._internal() {
    // 初始化
  }
  static MoveModule _getInstance() {
    if (_instance == null) {
      _instance = new MoveModule._internal();
    }
    return _instance;
  }

  static Map<String, List<MoveModel>> bindList(
      Map<String, List<MoveModel>> newmoves) {
    return instance.moves = newmoves;
  }

  static MoveModel bindItem(MoveModel newmove) {
    return newmove;
  }

  static Future<Map<String, List<MoveModel>>> fetchList() async {
    return dao
        .fetchMoveList()
        .then((listText) => dao.parseMoveList(listText))
        .then((listData) => bindList(listData));
  }

  static Future<MoveModel> fetchItem(String name) async {
    return dao
        .fetchMoveItem(name)
        .then((itemText) => dao.parseMoveItem(itemText));
  }

  static Future fetchItemHQImg(PokeModel model) async {
    return dao
        .fetchMoveImg(model.ndex, model.enname)
        .then((hqImg) => {model.hqImg = hqImg});
  }
}
