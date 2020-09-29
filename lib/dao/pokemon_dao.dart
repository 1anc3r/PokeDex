import 'dart:async';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:pokemon/dao/i_pokemon_dao.dart';
import 'package:pokemon/models/pokemon_model.dart';

class PokemonDao extends IPokemonDao {
  static RegExp normalRegExp = RegExp(
      r'^|(\w+|[\u4e00-\u9fa5]+)=([0-9]+|[a-zA-Z]+|[\u4e00-\u9fa5]+|[一-龠]+|[ぁ-ん]+|[ァ-ヴー]+|\w+|\s+)$');

  static Future<String> fetchPokemonList() async {
    return http
        .get(
            'https://wiki.52poke.com/index.php?title=%E5%AE%9D%E5%8F%AF%E6%A2%A6%E5%88%97%E8%A1%A8%EF%BC%88%E6%8C%89%E5%85%A8%E5%9B%BD%E5%9B%BE%E9%89%B4%E7%BC%96%E5%8F%B7%EF%BC%89/%E7%AE%80%E5%8D%95%E7%89%88&action=edit')
        .then((http.Response response) {
      Document document = parse(response.body.toString());
      String listText = document
          .getElementsByClassName('mw-editfont-monospace')[0]
          .text
          .toString();
      return listText;
    });
  }

  static Future<String> fetchPokemonItem(String name) async {
    return http
        .get('https://wiki.52poke.com/index.php?title=${name}&action=edit')
        .then((http.Response response) {
      Document document = parse(response.body.toString());
      String itemText = document
          .getElementsByClassName('mw-editfont-monospace')[0]
          .text
          .toString();
      return itemText;
    });
  }

  static List<PokemonModel> parsePokemonList(String listText) {
    List<PokemonModel> listData = [];
    if (listText.isNotEmpty) {
      List<String> lines = listText.split('\n');
      lines.forEach((line) {
        if (line.contains('Rdexe|')) {
          line = line.replaceAll('{{', '');
          line = line.replaceAll('}}', '');
          List<String> words = line.split('|');
          listData.add(PokemonModel(words[1], words[2], words[3], words[4]));
        }
      });
    }
    return listData;
  }

  static PokemonModel parsePokemonItem(String itemText) {
    PokemonModel model;
    Map<String, dynamic> modelkv = {};
    if (itemText.isNotEmpty) {
      List<String> lines = itemText.split('\n');
      lines.forEach((line) {
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
            modelkv.putIfAbsent(key, () => value);
          }
        }
      });

      model = PokemonModel.fromJson(modelkv);
    }
    return model;
  }
}
