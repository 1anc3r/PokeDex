import 'package:pokemon/utils/constants.dart';

class PokemonModel {
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

  PokemonModel(this.ndex, this.name, this.jname, this.enname) {
    url = '${Constants.POKEMON_INDEX_URL}?title=${name}&action=edit';
    lqImg = '${Constants.POKEMON_LQ_IMG_URL}/${processName(enname)}.png';
  }

  PokemonModel.fromJson(Map<String, dynamic> json) {
    if (json['ndex'] != null) {
      ndex = json['ndex']?.toString();
    }
    if (json['name'] != null) {
      name = json['name']?.toString();
      url = '${Constants.POKEMON_INDEX_URL}?title=${name}&action=edit';
    }
    if (json['jname'] != null) {
      jname = json['jname']?.toString();
    }
    if (json['enname'] != null) {
      enname = json['enname']?.toString();
      lqImg = '${Constants.POKEMON_LQ_IMG_URL}/${processName(this.enname)}.png';
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
      basePoints.putIfAbsent(Constants.HP, () => int.parse(json['evhp']));
    }
    if (json['evat'] != null) {
      basePoints.putIfAbsent(Constants.ATK, () => int.parse(json['evat']));
    }
    if (json['evde'] != null) {
      basePoints.putIfAbsent(Constants.DEF, () => int.parse(json['evde']));
    }
    if (json['evsa'] != null) {
      basePoints.putIfAbsent(Constants.SAT, () => int.parse(json['evsa']));
    }
    if (json['evsd'] != null) {
      basePoints.putIfAbsent(Constants.SDE, () => int.parse(json['evsd']));
    }
    if (json['evsp'] != null) {
      basePoints.putIfAbsent(Constants.SPD, () => int.parse(json['evsp']));
    }
    // 种族值
    if (json['HP'] != null) {
      speciesStrengths.putIfAbsent(Constants.HP, () => int.parse(json['HP']));
    }
    if (json[Constants.ATK] != null) {
      speciesStrengths.putIfAbsent(
          Constants.ATK, () => int.parse(json[Constants.ATK]));
    }
    if (json[Constants.DEF] != null) {
      speciesStrengths.putIfAbsent(
          Constants.DEF, () => int.parse(json[Constants.DEF]));
    }
    if (json[Constants.SAT] != null) {
      speciesStrengths.putIfAbsent(
          Constants.SAT, () => int.parse(json[Constants.SAT]));
    }
    if (json[Constants.SDE] != null) {
      speciesStrengths.putIfAbsent(
          Constants.SDE, () => int.parse(json[Constants.SDE]));
    }
    if (json[Constants.SPD] != null) {
      speciesStrengths.putIfAbsent(
          Constants.SPD, () => int.parse(json[Constants.SPD]));
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
