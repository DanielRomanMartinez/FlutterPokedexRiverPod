import 'package:flutter_pokedex/infrastructure/repositories/hive/hive_captured_pokemons_repository.dart';
import 'package:flutter_pokedex/infrastructure/repositories/hive/model/hive_pokemon.dart';
import 'package:flutter_pokedex/infrastructure/repositories/hive/model/hive_pokemon_type.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveProvider {
  static const capturedPokemons = 'capturedPokemons';

  bool _isInitializing = false;
  Map<String, Box<dynamic>>? _database;

  HiveProvider();

  Future<Map<String, Box<dynamic>>> get database async {
    if (_database == null && !_isInitializing) {
      try {
        lock();
        _database = await _initialize();
        release();
      } catch (e) {
        release();
      }
    } else if (_isInitializing) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      // ignore: recursive_getters
      await database;
    }

    return _database!;
  }

  void lock() {
    _isInitializing = true;
  }

  void release() {
    _isInitializing = false;
  }

  Future<void> dispose() async {
    await Hive.close();
    _database = null;
  }

  Future<Map<String, Box<dynamic>>> _initialize() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(HivePokemonAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(HivePokemonTypeAdapter());
    }

    final Map<String, Box<dynamic>> boxes = {};
    boxes[HiveCapturedPokemonsRepository.boxName] = await Hive.openBox<HivePokemon>(capturedPokemons);

    return boxes;
  }
}
