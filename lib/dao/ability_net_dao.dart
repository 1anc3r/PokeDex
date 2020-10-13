import 'dart:async';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:pokemon/consts/urls.dart';
import 'package:pokemon/models/ability_model.dart';

import 'i_ability_dao.dart';

class AbilityNetDao implements IAbilityDao {
  static RegExp listTitleRegExp = RegExp(r'==(.+?)==$');

  @override
  Future<String> fetchAbilityList() async {
    var listUrl = '${URLS.POKE_INDEX_URL}?title=特性列表&action=edit';
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
  Future<String> fetchAbilityItem(String name) async {
    var itemUrl = '${URLS.POKE_WIKI_URL}/${name}（特性）';
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
  Map<String, List<AbilityModel>> parseAbilityList(String listText) {
    var key = '';
    Map<String, List<AbilityModel>> listData = {};
    if (listText.isNotEmpty) {
      List<String> lines = listText.split('\n');
      lines.forEach((line) {
        if (line.contains('特性列表|')) {
          List<String> words =
              line.replaceAll('{{', '').replaceAll('}}', '').split('|');
          AbilityModel ability = new AbilityModel(
              words[0], words[1], words[2], words[3], words[4]);
          listData[key].add(ability);
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
  AbilityModel parseAbilityItem(String itemText) {
    return null;
  }
}
