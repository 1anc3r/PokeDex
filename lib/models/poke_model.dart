import 'package:pokemon/consts/strings.dart';
import 'package:pokemon/consts/urls.dart';

import 'move_model.dart';

class PokeModel {
  String ndex;
  String url;
  String lqImg;
  String hqImg;
  String typeImg;

  String name; // 妙蛙种子
  String jname; // フシギダネ
  String enname; // Bulbasaur
  String species; // 种子

  List<String> types = []; // 草 | 毒
  List<String> egggroups = []; // 怪兽 | 植物
  List<String> abilities = []; // 茂盛

  int gendercode; // 31
  int eggcycles; // 20
  int catchrate; // 45
  String lv100exp; // 1,059,860
  double height; // 0.7
  double weight; // 6.9
  String color; // 绿
  Map<String, int> speciesStrengths = {};
  Map<String, int> basePoints = {};

  List<MoveModel> levellist = [
    MoveModel(0, '等级', '招式', '属性', '分类', '威力', '命中', 'PP')
  ];
  List<MoveModel> tmlist = [
    MoveModel(1, 'TM', '招式', '属性', '分类', '威力', '命中', 'PP')
  ];
  List<MoveModel> trlist = [
    MoveModel(1, 'TR', '招式', '属性', '分类', '威力', '命中', 'PP')
  ];
  List<MoveModel> breedlist = [
    MoveModel(2, '亲代', '招式', '属性', '分类', '威力', '命中', 'PP')
  ];
  List<MoveModel> tutorlist = [
    MoveModel(3, ' ', '招式', '属性', '分类', '威力', '命中', 'PP')
  ];

  PokeModel(this.ndex, this.name, this.jname, this.enname) {
    url = '${URLS.POKE_INDEX_URL}?title=${name}&action=edit';
    lqImg = '${URLS.POKE_SPT_URL}/${processName(enname)}.png';
  }

  PokeModel.fromJson(Map<String, dynamic> json) {
    if (json['ndex'] != null) {
      ndex = json['ndex']?.toString();
    }
    if (json['name'] != null) {
      name = json['name']?.toString();
      url = '${URLS.POKE_INDEX_URL}?title=${name}&action=edit';
    }
    if (json['jname'] != null) {
      jname = json['jname']?.toString();
    }
    if (json['enname'] != null) {
      enname = json['enname']?.toString();
      lqImg = '${URLS.POKE_SPT_URL}/${processName(this.enname)}.png';
    }

    if (json['species'] != null) {
      species = json['species']?.toString();
    }
    if (json['abilityd'] != null) {
      abilities.add('${json['abilityd']?.toString()}(隐藏特性)');
    }
    if (json['gendercode'] != null) {
      gendercode = int.parse(json['gendercode']);
    }
    if (json['eggcycles'] != null) {
      eggcycles = int.parse(json['eggcycles']);
    }
    if (json['lv100exp'] != null) {
      lv100exp = json['lv100exp']?.toString();
    }
    if (json['color'] != null) {
      color = json['color']?.toString();
    }

    if (json['catchrate'] != null) {
      catchrate = int.parse(json['catchrate']);
    }
    if (json['height'] != null) {
      height = double.parse(json['height']);
    }
    if (json['weight'] != null) {
      weight = double.parse(json['weight']);
    }
    // 基础点数
    if (json['evhp'] != null) {
      basePoints.putIfAbsent(STRINGS.HP, () => int.parse(json['evhp']));
    }
    if (json['evat'] != null) {
      basePoints.putIfAbsent(STRINGS.ATK, () => int.parse(json['evat']));
    }
    if (json['evde'] != null) {
      basePoints.putIfAbsent(STRINGS.DEF, () => int.parse(json['evde']));
    }
    if (json['evsa'] != null) {
      basePoints.putIfAbsent(STRINGS.SAT, () => int.parse(json['evsa']));
    }
    if (json['evsd'] != null) {
      basePoints.putIfAbsent(STRINGS.SDE, () => int.parse(json['evsd']));
    }
    if (json['evsp'] != null) {
      basePoints.putIfAbsent(STRINGS.SPD, () => int.parse(json['evsp']));
    }
    // 种族值
    if (json['HP'] != null) {
      speciesStrengths.putIfAbsent(STRINGS.HP, () => int.parse(json['HP']));
    }
    if (json[STRINGS.ATK] != null) {
      speciesStrengths.putIfAbsent(
          STRINGS.ATK, () => int.parse(json[STRINGS.ATK]));
    }
    if (json[STRINGS.DEF] != null) {
      speciesStrengths.putIfAbsent(
          STRINGS.DEF, () => int.parse(json[STRINGS.DEF]));
    }
    if (json[STRINGS.SAT] != null) {
      speciesStrengths.putIfAbsent(
          STRINGS.SAT, () => int.parse(json[STRINGS.SAT]));
    }
    if (json[STRINGS.SDE] != null) {
      speciesStrengths.putIfAbsent(
          STRINGS.SDE, () => int.parse(json[STRINGS.SDE]));
    }
    if (json[STRINGS.SPD] != null) {
      speciesStrengths.putIfAbsent(
          STRINGS.SPD, () => int.parse(json[STRINGS.SPD]));
    }

    var typNum = 1;
    while (json.containsKey('type$typNum') && ['type$typNum'] != null) {
      types.add(json['type$typNum']?.toString());
      typNum++;
    }
    var abiNum = 1;
    while (json.containsKey('ability$abiNum') && ['ability$abiNum'] != null) {
      abilities.add(json['ability$abiNum']?.toString());
      abiNum++;
    }
    var eggNum = 1;
    while (json.containsKey('egggroup$eggNum') && ['egggroup$eggNum'] != null) {
      egggroups.add(json['egggroup$eggNum']?.toString());
      eggNum++;
    }
  }

  String processName(String name) {
    return name
        .toLowerCase()
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll('\'', '')
        .replaceAll('♀', 'f')
        .replaceAll('♂', 'm');
  }

  toString() {
    return '[dex=$ndex][name=$name][jname=$jname][enname=$enname]';
  }
}
