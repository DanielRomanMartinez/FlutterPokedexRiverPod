import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/domain/repositories/captured_pokemon_repository.dart';
import 'package:flutter_pokedex/domain/repositories/pokemon_repository.dart';
import 'package:flutter_pokedex/domain/services/get_storage_service.dart';
import 'package:flutter_pokedex/domain/services/http_service.dart';
import 'package:flutter_pokedex/domain/services/start_up_route_service.dart';
import 'package:flutter_pokedex/domain/services/user_service.dart';
import 'package:flutter_pokedex/infrastructure/providers/hive_provider.dart';
import 'package:flutter_pokedex/infrastructure/repositories/hive/hive_captured_pokemons_repository.dart';
import 'package:flutter_pokedex/infrastructure/repositories/http/pokemon_repository.dart';
import 'package:flutter_pokedex/infrastructure/services/get_storage_service.dart';
import 'package:flutter_pokedex/infrastructure/services/http_service.dart';
import 'package:flutter_pokedex/infrastructure/services/start_up_service.dart';
import 'package:flutter_pokedex/infrastructure/services/user_service.dart';

part 'providers.g.dart';

@riverpod
GetStorageService getStorageService(Ref ref) {
  return FlutterGetStorageService();
}

@riverpod
HttpService httpService(Ref ref) {
  return FlutterHttpService();
}

@riverpod
HiveProvider hiveProvider(Ref ref) {
  return HiveProvider();
}

@riverpod
CapturedPokemonsRepository capturedPokemonsRepository(Ref ref) {
  return HiveCapturedPokemonsRepository(ref.read(hiveProviderProvider));
}

@riverpod
PokemonRepository pokemonRepository(Ref ref) {
  return HttpPokemonRepository(
    ref.read(httpServiceProvider),
    ref.read(capturedPokemonsRepositoryProvider),
  );
}

@riverpod
StartUpRouteService startUpRouteService(Ref ref) {
  return StartUpRouteService(
    getStorageService: ref.read(getStorageServiceProvider),
  );
}

@riverpod
UserService userService(Ref ref) {
  return InfrastructureUserService(
    ref.read(capturedPokemonsRepositoryProvider),
  );
}

@riverpod
FlutterStartUpService startUpService(Ref ref) {
  return FlutterStartUpService(
    getStorageService: ref.read(getStorageServiceProvider),
  );
}
