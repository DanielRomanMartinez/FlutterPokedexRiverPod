import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/domain/model/objects/pokemon.dart';
import 'package:flutter_pokedex/config/providers.dart';
import 'package:flutter_pokedex/application/screens/captured_pokemons/captured_pokemons_screen_notifier.dart';
import 'package:flutter_pokedex/application/screens/user_information/user_information_notifier.dart';

part 'pokemon_detail_screen_notifier.g.dart';

@riverpod
class PokemonDetailScreenNotifier extends _$PokemonDetailScreenNotifier {
  @override
  Future<Pokemon?> build(String pokemonName) async {
    final repository = ref.read(pokemonRepositoryProvider);
    return await repository.getPokemonByName(pokemonName);
  }

  Future<void> capturePokemon(Pokemon pokemon) async {
    final capturedRepo = ref.read(capturedPokemonsRepositoryProvider);
    await capturedRepo.markAsCaptured(pokemon);

    ref.invalidateSelf();

    ref.invalidate(capturedPokemonsScreenNotifierProvider);
    ref.invalidate(userInformationNotifierProvider);
  }

  Future<void> unleashPokemon(Pokemon pokemon) async {
    final capturedRepo = ref.read(capturedPokemonsRepositoryProvider);
    await capturedRepo.removePokemon(pokemon.id);

    ref.invalidateSelf();

    ref.invalidate(capturedPokemonsScreenNotifierProvider);
    ref.invalidate(userInformationNotifierProvider);
  }
}