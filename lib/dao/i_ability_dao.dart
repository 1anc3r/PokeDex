import 'dart:async';

import 'package:pokemon/models/ability_model.dart';

abstract class IAbilityDao {
  Future<String> fetchAbilityList();

  Future<String> fetchAbilityItem(String name);

  Map<String, List<AbilityModel>> parseAbilityList(String listText);

  AbilityModel parseAbilityItem(String itemText);
}
