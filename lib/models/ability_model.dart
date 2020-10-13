import 'package:pokemon/models/poke_model.dart';

class AbilityModel {
  String n; // 1
  String name; // 铁刺
  String jname; // てつのトゲ
  String enname; // Iron Barbs
  String text; // 用铁刺给予接触到自己的对手伤害。;zh-hant:用鐵刺給予接觸到自己的對手傷害
  String info; // 受到[[接触类招式]]攻击时对手会损失最大体力的{{frac|1|8}}
  String colorscheme; // 钢

  List<PokeModel> pokelist = [];

  AbilityModel(this.n, this.name, this.jname, this.enname, this.text) {}
}
