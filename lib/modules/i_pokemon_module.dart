import 'package:pokemon/models/pokemon_model.dart';

class IPokemonModule {
  static List<PokemonModel> bindList;
  static PokemonModel bindItem;
  static Future<List<PokemonModel>> fetchList;
  static Future<PokemonModel> fetchItem;
}
