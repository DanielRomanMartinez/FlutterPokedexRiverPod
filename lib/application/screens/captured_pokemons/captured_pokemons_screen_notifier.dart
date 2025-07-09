import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/domain/model/objects/pokemon.dart';
import 'package:flutter_pokedex/config/providers.dart';

part 'captured_pokemons_screen_notifier.g.dart';

@riverpod
class CapturedPokemonsScreenNotifier extends _$CapturedPokemonsScreenNotifier {
  @override
  Future<List<Pokemon>> build() async {
    final repository = ref.read(capturedPokemonsRepositoryProvider);
    return await repository.getPokemons();
  }

  Future<void> searchPokemon(String name) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(capturedPokemonsRepositoryProvider);
      final result = await repository.getPokemons(name: name);
      state = AsyncValue.data(result);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}