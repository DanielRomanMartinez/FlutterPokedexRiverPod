import 'package:flutter_pokedex/domain/model/objects/pokemon.dart';

abstract class PokemonRepository {
  Future<Pokemon?> getPokemonByName(String name);

  Future<Map<String, dynamic>> getPokemons({
    required int offset,
    required int limit,
    bool cached = true,
  });
}
