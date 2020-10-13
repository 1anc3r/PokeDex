import 'package:pokemon/dao/ability_net_dao.dart';
import 'package:pokemon/dao/move_net_dao.dart';
import 'package:pokemon/models/ability_model.dart';
import 'package:pokemon/models/move_model.dart';
import 'package:pokemon/models/poke_model.dart';

class AbilityModule {
  Map<String, List<AbilityModel>> moves = {};

  static AbilityNetDao dao = new AbilityNetDao();

  factory AbilityModule() => _getInstance();
  static AbilityModule get instance => _getInstance();
  static AbilityModule _instance;

  AbilityModule._internal() {
    // 初始化
  }
  static AbilityModule _getInstance() {
    if (_instance == null) {
      _instance = new AbilityModule._internal();
    }
    return _instance;
  }

  static Map<String, List<AbilityModel>> bindList(
      Map<String, List<AbilityModel>> newmoves) {
    return instance.moves = newmoves;
  }

  static AbilityModel bindItem(AbilityModel newmove) {
    return newmove;
  }

  static Future<Map<String, List<AbilityModel>>> fetchList() async {
    return dao
        .fetchAbilityList()
        .then((listText) => dao.parseAbilityList(listText))
        .then((listData) => bindList(listData));
  }

  static Future<AbilityModel> fetchItem(String name) async {
    return dao
        .fetchAbilityItem(name)
        .then((itemText) => dao.parseAbilityItem(itemText));
  }
}
