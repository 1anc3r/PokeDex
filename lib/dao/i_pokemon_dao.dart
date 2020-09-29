import 'dart:async';

abstract class IPokemonDao {
  static Future<String> fetchPokemonList;
  static Future<String> fetchPokemonItem;
  static Future<String> parsePokemonList;
  static Future<String> parsePokemonItem;
}
