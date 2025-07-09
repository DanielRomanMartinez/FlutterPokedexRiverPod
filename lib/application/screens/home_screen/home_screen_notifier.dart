import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/config/providers.dart';

part 'home_screen_notifier.g.dart';

@riverpod
class HomeScreenNotifier extends _$HomeScreenNotifier {
  @override
  Future<Map<String, dynamic>> build() async {
    final repository = ref.read(pokemonRepositoryProvider);
    return await repository.getPokemons(
      offset: 0,
      limit: 151,
      cached: true,
    );
  }

  Future<void> refresh({bool cached = true}) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(pokemonRepositoryProvider);
      final result = await repository.getPokemons(
        offset: 0,
        limit: 151,
        cached: cached,
      );
      state = AsyncValue.data(result);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}