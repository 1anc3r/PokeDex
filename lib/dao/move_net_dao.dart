import 'dart:async';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:pokemon/consts/urls.dart';
import 'package:pokemon/dao/i_move_dao.dart';
import 'package:pokemon/models/move_model.dart';

class MoveNetDao implements IMoveDao {
  static RegExp listTitleRegExp = RegExp(r'==(.+?)==$');

  @override
  Future<String> fetchMoveList() async {
    var listUrl = '${URLS.POKE_INDEX_URL}?title=招式列表&action=edit';
    return http.get(listUrl).then((http.Response response) {
      Document document = parse(response.body.toString());
      String listText = document
          .getElementsByClassName('mw-editfont-monospace')[0]
          .text
          .toString();
      return listText;
    });
  }

  @override
  Future<String> fetchMoveItem(String name) async {
    var itemUrl = '${URLS.POKE_WIKI_URL}/${name}（招式）';
    return http.get(itemUrl).then((http.Response response) {
      Document document = parse(response.body.toString());
      String itemText = document
          .getElementsByClassName('mw-editfont-monospace')[0]
          .text
          .toString();
      return itemText;
    });
  }

  @override
  Future<String> fetchMoveImg(String ndex, String gameimag) async {
    if (gameimag.isEmpty) {
      String imgUrl = '${URLS.MOVE_GIT_URL}${ndex}.gif';
      imgUrl =
          imgUrl.replaceAll('//media.52poke.com/', 'http://s1.52poke.wiki/');
      return new Future.value();
    } else {
      var hqImgUrl = '${URLS.POKE_FILE_URL}${gameimag}';
      return http.get(hqImgUrl).then((http.Response response) {
        Document document = parse(response.body.toString());
        String imgUrl = document
            .getElementsByClassName('fullImageLink')[0]
            .getElementsByTagName('img')[0]
            .attributes['src']
            .toString();
        imgUrl =
            imgUrl.replaceAll('//media.52poke.com/', 'http://s1.52poke.wiki/');
        return imgUrl;
      });
    }
  }

  @override
  Map<String, List<MoveModel>> parseMoveList(String listText) {
    var key = '';
    Map<String, List<MoveModel>> listData = {};
    if (listText.isNotEmpty) {
      List<String> lines = listText.split('\n');
      lines.forEach((line) {
        if (line.contains('Movelist/gen/ex|')) {
          List<String> words =
              line.replaceAll('{{', '').replaceAll('}}', '').split('|');
          MoveModel move = new MoveModel(0, key, words[2], words[5], words[6],
              words[7], words[8], words[9]);
          move.n = words[1];
          move.jname = words[3];
          move.enname = words[4];
          listData[key].add(move);
        } else {
          if (listTitleRegExp.hasMatch(line)) {
            var matches = listTitleRegExp.allMatches(line);
            if (matches.length > 0) {
              var match = matches.elementAt(0);
              if (match.groupCount == 1) {
                key = '${match.group(1)}';
                listData.putIfAbsent(key, () => []);
              }
            }
          }
        }
      });
    }
    return listData;
  }

  @override
  MoveModel parseMoveItem(String itemText) {
    return null;
  }
}
