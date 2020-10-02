import 'dart:async';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:pokemon/models/move_model.dart';
import 'package:pokemon/models/poke_model.dart';
import 'package:pokemon/utils/constants.dart';
import 'package:pokemon/utils/log_util.dart';

class PokeDao {
  static RegExp listTitleRegExp =
      RegExp(r'===<span class=t-(.+?)>\[\[(.+?)\]\]<\/span>===$');
  static RegExp keyValueRegExp = RegExp(r'^|(.+?)=(.+?)$');

  static Future<String> fetchPokeList() async {
    var listUrl = '${Constants.POKE_INDEX_URL}${Constants.POKE_CN_LIST_URL}';
    return http.get(listUrl).then((http.Response response) {
      Document document = parse(response.body.toString());
      String listText = document
          .getElementsByClassName('mw-editfont-monospace')[0]
          .text
          .toString();
      return listText;
    });
  }

  static Future<String> fetchPokeItem(String name) async {
    var itemUrl = '${Constants.POKE_INDEX_URL}?title=${name}&action=edit';
    return http.get(itemUrl).then((http.Response response) {
      Document document = parse(response.body.toString());
      String itemText = document
          .getElementsByClassName('mw-editfont-monospace')[0]
          .text
          .toString();
      return itemText;
    });
  }

  static Future<String> fetchPokeHQImg(String ndex, String enname) async {
    var hqImgUrl = '${Constants.POKE_HQ_IMG_URL}${ndex}${enname}.png';
    return http.get(hqImgUrl).then((http.Response response) {
      Document document = parse(response.body.toString());
      String imgUrl = document
          .getElementsByClassName('fullImageLink')[0]
          .getElementsByTagName('img')[0]
          .attributes['src']
          .toString();
      imgUrl = imgUrl
          .replaceAll('//media.52poke.com/', 'http://s1.52poke.wiki/')
          .replaceAll('600px', '300px');
      return imgUrl;
    });
  }

  static Map<String, List<PokeModel>> parsePokeList(String listText) {
    var key = '';
    Map<String, List<PokeModel>> listData = {};
    if (listText.isNotEmpty) {
      List<String> lines = listText.split('\n');
      lines.forEach((line) {
        if (line.contains('Rdexe|')) {
          List<String> words =
              line.replaceAll('{{', '').replaceAll('}}', '').split('|');
          listData[key].add(PokeModel(words[1], words[2], words[3], words[4]));
        } else {
          line = line.replaceAll('\'', '').replaceAll('\"', '');
          if (listTitleRegExp.hasMatch(line)) {
            var matches = listTitleRegExp.allMatches(line);
            if (matches.length > 0) {
              var match = matches.elementAt(0);
              if (match.groupCount == 2) {
                key = '${match.group(2)} ${match.group(1)}地区';
                listData.putIfAbsent(key, () => []);
              }
            }
          }
        }
      });
    }
    return listData;
  }

  static PokeModel parsePokeItem(String itemText) {
    PokeModel model;
    Map<String, dynamic> modelkv = {};
    List<List<MoveModel>> listData = [[], [], [], [], [], [], []];
    if (itemText.isNotEmpty) {
      List<String> lines = itemText.split('\n');
      lines.forEach((line) {
        modelkv.addAll(parseNormal(line));
        var move = parseMove(line);
        if (move != null) {
          listData[move.sourceType].add(move);
        }
      });
      model = PokeModel.fromJson(modelkv);
      model.levellist.addAll(listData[0]);
      model.tmlist.addAll(listData[1]);
      model.trlist.addAll(listData[2]);
      model.breedlist.addAll(listData[3]);
      model.tutorlist.addAll(listData[4]);
      return model;
    }
  }

  static Map<String, dynamic> parseNormal(String line) {
    Map<String, dynamic> kv = {};
    if (keyValueRegExp.hasMatch(line)) {
      var key = '', value = '';
      var matches = keyValueRegExp.allMatches(line);
      if (matches.length > 1) {
        var match = matches.elementAt(1);
        if (match.groupCount == 2) {
          key = match.group(1);
          value = match.group(2);
        }
      }
      if (key.isNotEmpty && value.isNotEmpty) {
        kv.putIfAbsent(key, () => value);
      }
    }
    return kv;
  }

  static MoveModel parseMove(String line) {
    MoveModel move;

    List<bool> bowl = [
      line.contains(new RegExp(r'learnlist/level\d')), // 升级
      line.contains(new RegExp(r'learnlist/tm\d')), // 招式学习器
      line.contains(new RegExp(r'learnlist/breed\d')), // 蛋招式
      line.contains(new RegExp(r'learnlist/tutor\d')) // 教授招式
    ];

    if (line.contains('|{{') && line.contains('}}|') && bowl[2]) {
      var words1 = line.split('|{{');
      var words2 = words1[1].split('}}|');
      line = words2[1];
    }

    var words = line
        .replaceAll('&mash;', '—')
        .replaceAll('&mdash;', '—')
        .replaceAll('{', '')
        .replaceAll('}', '')
        .split('|');

    if ((bowl[0] || bowl[1]) && words.length > 7) {
      move = MoveModel(bowl[0] ? 0 : (words[1].contains('招式学习器') ? 1 : 2),
          words[1], words[2], words[3], words[4], words[5], words[6], words[7]);
    }
    if (bowl[2] && words.length > 5) {
      move = MoveModel(
          3, '亲代', words[0], words[1], words[2], words[3], words[4], words[5]);
    }
    if (bowl[3] && words.length > 6) {
      move = MoveModel(
          4, '', words[1], words[2], words[3], words[4], words[5], words[6]);
    }
    return move;
  }

  static parseCatchMethod(String line) {
    MoveModel move;

    bool flag = line.contains(new RegExp(r'分布/main'));

    var words = line.replaceAll('{', '').replaceAll('}', '').split('|');

    if (flag && words.length > 7) {}
    return move;
  }
}
