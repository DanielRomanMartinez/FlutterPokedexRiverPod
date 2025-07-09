import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/application/screens/home_screen/home_screen_notifier.dart';
import 'package:flutter_pokedex/config/providers.dart';
import 'package:flutter_pokedex/domain/model/objects/pokemon.dart';
import 'package:flutter_pokedex/domain/model/objects/pokemon_type.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_screen_notifier_test.mocks.dart';

@GenerateMocks([
  PokemonRepository,
])
void main() {
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
  });

  group('Home Screen Notifier', () {
    const Pokemon pokemon = Pokemon(
      id: 1,
      name: 'Bulbasaur',
      description: 'Description',
      height: 10,
      weight: 10,
      isCaptured: false,
      image: '',
      types: [
        PokemonType(name: 'grass'),
      ],
    );

    final List<Pokemon> pokemons = [pokemon];
    final expectedResponse = {
      'offset': 0,
      'limit': 151,
      'content': pokemons,
    };

    test('should load pokemons successfully', () async {
      when(mockPokemonRepository.getPokemons(
        offset: 0,
        limit: 151,
        cached: true,
      )).thenAnswer((_) async => expectedResponse);

      final container = ProviderContainer(
        overrides: [
          pokemonRepositoryProvider.overrideWithValue(mockPokemonRepository),
        ],
      );

      final result = await container.read(homeScreenNotifierProvider.future);

      expect(result, equals(expectedResponse));
      verify(mockPokemonRepository.getPokemons(
        offset: 0,
        limit: 151,
        cached: true,
      )).called(1);

      container.dispose();
    });

    test('should refresh with cached=false', () async {
      when(mockPokemonRepository.getPokemons(
        offset: 0,
        limit: 151,
        cached: false,
      )).thenAnswer((_) async => expectedResponse);

      final container = ProviderContainer(
        overrides: [
          pokemonRepositoryProvider.overrideWithValue(mockPokemonRepository),
        ],
      );

      await container.read(homeScreenNotifierProvider.notifier).refresh(cached: false);
      final result = container.read(homeScreenNotifierProvider);

      expect(result.value, equals(expectedResponse));
      verify(mockPokemonRepository.getPokemons(
        offset: 0,
        limit: 151,
        cached: false,
      )).called(1);

      container.dispose();
    });

    test('should handle errors gracefully', () async {
      when(mockPokemonRepository.getPokemons(
        offset: 0,
        limit: 151,
        cached: true,
      )).thenThrow(Exception('Network error'));

      final container = ProviderContainer(
        overrides: [
          pokemonRepositoryProvider.overrideWithValue(mockPokemonRepository),
        ],
      );

      expect(
        () async => await container.read(homeScreenNotifierProvider.future),
        throwsA(isA<Exception>()),
      );

      container.dispose();
    });
  });
}
