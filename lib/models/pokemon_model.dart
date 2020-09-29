import 'package:pokemon/utils/constant.dart';

class PokemonModel {
  String ndex;
  String url;
  String lqImg;
  String hqImg;

  String name; // 妙蛙种子
  String jname; // フシギダネ
  String enname; // Bulbasaur
  String species; // 种子
  List<String> types = []; // 草 | 毒
  List<String> egggroups = []; // 怪兽 | 植物
  List<String> abilities = []; // 茂盛
  String abilityd; // 隐藏特性 叶绿素
  String lv100exp; // 1,059,860
  String color; // 绿

  int catchrate;
  int height; // 0.7
  int weight; // 6.9
  int evhp; // 0
  int evatk; // 0
  int evdef; // 0
  int evsatk; // 1
  int evsdef; // 0
  int evspd; // 0
  int bshp; // 45
  int bsatk; // 49
  int bsdef; // 65
  int bssatk; // 65
  int bssdef; // 45
  int bsspd; // 65

  PokemonModel(this.ndex, this.name, this.jname, this.enname) {
    url = '${Constant.POKEMON_CN_PRE_URL}?title=${name}&action=edit';
    lqImg = '${Constant.POKEMON_LQ_IMG_URL}/${processName(enname)}.png';
  }

  PokemonModel.fromJson(Map<String, dynamic> json) {
    if (json['ndex'] != null) {
      ndex = json['ndex']?.toString();
    }
    if (json['name'] != null) {
      name = json['name']?.toString();
      url = '${Constant.POKEMON_CN_PRE_URL}?title=${name}&action=edit';
    }
    if (json['jname'] != null) {
      jname = json['jname']?.toString();
    }
    if (json['enname'] != null) {
      enname = json['enname']?.toString();
      lqImg = '${Constant.POKEMON_LQ_IMG_URL}/${processName(this.enname)}.png';
    }
    if (json['species'] != null) {
      species = json['species']?.toString();
    }
    if (json['abilityd'] != null) {
      abilityd = json['abilityd']?.toString();
    }
    if (json['color'] != null) {
      color = json['color']?.toString();
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
