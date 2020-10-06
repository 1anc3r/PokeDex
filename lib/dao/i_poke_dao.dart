import 'dart:async';

import 'package:pokemon/models/poke_model.dart';

abstract class IPokeDao {
  Future<String> fetchPokeList();

  Future<String> fetchPokeItem(String name);

  Future<String> fetchPokeImg(String ndex, String enname);

  Map<String, List<PokeModel>> parsePokeList(String listText);

  PokeModel parsePokeItem(String itemText);
}
