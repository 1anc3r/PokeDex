import 'dart:async';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:pokemon/dao/i_pokemon_dao.dart';
import 'package:pokemon/models/pokemon_model.dart';
import 'package:pokemon/utils/constants.dart';
import 'package:pokemon/utils/log_util.dart';

class PokemonDao extends IPokemonDao {
  static RegExp normalRegExp = RegExp(r'^|(\w+|[\u4e00-\u9fa5]+)=(.+?)$');

  static Future<String> fetchPokemonList() async {
    return http
        .get('${Constants.POKEMON_INDEX_URL}${Constants.POKEMON_CN_LIST_URL}')
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
        .get('${Constants.POKEMON_INDEX_URL}?title=${name}&action=edit')
        .then((http.Response response) {
      Document document = parse(response.body.toString());
      String itemText = document
          .getElementsByClassName('mw-editfont-monospace')[0]
          .text
          .toString();
      return itemText;
    });
  }

  static Future<String> fetchPokemonHQImg(String ndex, String enname) async {
    return http
        .get('${Constants.POKEMON_HQ_IMG_URL}${ndex}${enname}.png')
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
      return model;
    }
  }
}
