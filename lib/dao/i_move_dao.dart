import 'dart:async';

import 'package:pokemon/models/move_model.dart';

abstract class IMoveDao {
  Future<String> fetchMoveList();

  Future<String> fetchMoveItem(String name);

  Future<String> fetchMoveImg(String ndex, String gameimag);

  Map<String, List<MoveModel>> parseMoveList(String listText);

  MoveModel parseMoveItem(String itemText);
}
