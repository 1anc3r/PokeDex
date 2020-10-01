import 'dart:async';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:pokemon/models/move_model.dart';
import 'package:pokemon/models/poke_model.dart';
import 'package:pokemon/utils/constants.dart';

class PokeDao {
  static RegExp normalRegExp = RegExp(r'^|(\w+|[\u4e00-\u9fa5]+)=(.+?)$');

  static Future<String> fetchPokeList() async {
    return http
        .get('${Constants.POKE_INDEX_URL}${Constants.POKE_CN_LIST_URL}')
        .then((http.Response response) {
      Document document = parse(response.body.toString());
      String listText = document
          .getElementsByClassName('mw-editfont-monospace')[0]
          .text
          .toString();
      return listText;
    });
  }

  static Future<String> fetchPokeItem(String name) async {
    return http
        .get('${Constants.POKE_INDEX_URL}?title=${name}&action=edit')
        .then((http.Response response) {
      Document document = parse(response.body.toString());
      String itemText = document
          .getElementsByClassName('mw-editfont-monospace')[0]
          .text
          .toString();
      return itemText;
    });
  }

  static Future<String> fetchPokeHQImg(String ndex, String enname) async {
    return http
        .get('${Constants.POKE_HQ_IMG_URL}${ndex}${enname}.png')
        .then((http.Response response) {
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

  static List<PokeModel> parsePokeList(String listText) {
    List<PokeModel> listData = [];
    if (listText.isNotEmpty) {
      List<String> lines = listText.split('\n');
      lines.forEach((line) {
        if (line.contains('Rdexe|')) {
          line = line.replaceAll('{{', '');
          line = line.replaceAll('}}', '');
          List<String> words = line.split('|');
          listData.add(PokeModel(words[1], words[2], words[3], words[4]));
        }
      });
    }
    return listData;
  }

  static PokeModel parsePokeItem(String itemText) {
    PokeModel model;
    Map<String, dynamic> modelkv = {};
    List<MoveModel> levellist = [];
    List<MoveModel> tmlist = [];
    List<MoveModel> breedlist = [];
    List<MoveModel> tutorlist = [];
    if (itemText.isNotEmpty) {
      List<String> lines = itemText.split('\n');
      lines.forEach((line) {
        modelkv.addAll(parseNormal(line));
        var move = parseMove(line);
        if (move != null) {
          switch (move.sourceType) {
            case 0:
              levellist.add(move);
              break;
            case 1:
              tmlist.add(move);
              break;
            case 2:
              breedlist.add(move);
              break;
            case 3:
              tutorlist.add(move);
              break;
          }
        }
      });
      model = PokeModel.fromJson(modelkv);
      model.levellist = levellist;
      model.tmlist = tmlist;
      model.breedlist = breedlist;
      model.tutorlist = tutorlist;
      return model;
    }
  }

  static Map<String, dynamic> parseNormal(String line) {
    Map<String, dynamic> kv = {};
    if (normalRegExp.hasMatch(line)) {
      var matches = normalRegExp.allMatches(line);
      var key = '', value = '';
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
    List<bool> bowl = [
      line.contains('learnlist/level8'), // 升级
      line.contains('learnlist/tm8'), // 招式学习器
      line.contains('learnlist/breed8'), // 蛋招式
      line.contains('learnlist/tutor8') // 教授招式
    ];
    MoveModel move;
    var words = line
        .replaceAll('&mash;', '—')
        .replaceAll(new RegExp(r'{{MSP\|\d+\|'), ' ')
        .replaceAll('||', '')
        .replaceAll('{', '')
        .replaceAll('}', '')
        .split('|');
    // 升级
    if (bowl[0] || bowl[1] || bowl[2]) {
      move = MoveModel(bowl[0] ? 0 : (bowl[1] ? 1 : 2), words[1], words[2],
          words[3], words[4], words[5], words[6], words[7]);
    }
    if (bowl[3]) {
      move = MoveModel(
          3, '', words[1], words[2], words[3], words[4], words[5], words[6]);
    }
    return move;
  }
}
