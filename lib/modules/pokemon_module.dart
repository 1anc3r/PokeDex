import 'package:pokemon/dao/pokemon_dao.dart';
import 'package:pokemon/models/pokemon_model.dart';

import 'i_pokemon_module.dart';

class PokemonModule extends IPokemonModule {
  List<PokemonModel> pokemons = [];

  factory PokemonModule() => _getInstance();
  static PokemonModule get instance => _getInstance();
  static PokemonModule _instance;
  PokemonModule._internal() {
    // 初始化
  }
  static PokemonModule _getInstance() {
    if (_instance == null) {
      _instance = new PokemonModule._internal();
    }
    return _instance;
  }

  static List<PokemonModel> bindList(List<PokemonModel> newpokemons) {
    return instance.pokemons = newpokemons;
  }

  static PokemonModel bindItem(PokemonModel newpokemon) {
    return newpokemon;
  }

  static Future<List<PokemonModel>> fetchList() async {
    return PokemonDao.fetchPokemonList()
        .then((listText) => PokemonDao.parsePokemonList(listText))
        .then((listData) => bindList(listData));
  }

  static Future<PokemonModel> fetchItem(String name) async {
    return PokemonDao.fetchPokemonItem(name)
        .then((itemText) => PokemonDao.parsePokemonItem(itemText))
        .then((itemData) => bindItem(itemData));
  }

  static Future fetchItemHQImg(PokemonModel model) async {
    return PokemonDao.fetchPokemonHQImg(model.ndex, model.enname)
        .then((hqImg) => {model.hqImg = hqImg});
  }
}
