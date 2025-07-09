// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_screen_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pokemonDetailScreenNotifierHash() =>
    r'6801d7dc109b3c2f91fcc623ac1e5af4c451919b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PokemonDetailScreenNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Pokemon?> {
  late final String pokemonName;

  FutureOr<Pokemon?> build(
    String pokemonName,
  );
}

/// See also [PokemonDetailScreenNotifier].
@ProviderFor(PokemonDetailScreenNotifier)
const pokemonDetailScreenNotifierProvider = PokemonDetailScreenNotifierFamily();

/// See also [PokemonDetailScreenNotifier].
class PokemonDetailScreenNotifierFamily extends Family<AsyncValue<Pokemon?>> {
  /// See also [PokemonDetailScreenNotifier].
  const PokemonDetailScreenNotifierFamily();

  /// See also [PokemonDetailScreenNotifier].
  PokemonDetailScreenNotifierProvider call(
    String pokemonName,
  ) {
    return PokemonDetailScreenNotifierProvider(
      pokemonName,
    );
  }

  @override
  PokemonDetailScreenNotifierProvider getProviderOverride(
    covariant PokemonDetailScreenNotifierProvider provider,
  ) {
    return call(
      provider.pokemonName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pokemonDetailScreenNotifierProvider';
}

/// See also [PokemonDetailScreenNotifier].
class PokemonDetailScreenNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PokemonDetailScreenNotifier,
        Pokemon?> {
  /// See also [PokemonDetailScreenNotifier].
  PokemonDetailScreenNotifierProvider(
    String pokemonName,
  ) : this._internal(
          () => PokemonDetailScreenNotifier()..pokemonName = pokemonName,
          from: pokemonDetailScreenNotifierProvider,
          name: r'pokemonDetailScreenNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pokemonDetailScreenNotifierHash,
          dependencies: PokemonDetailScreenNotifierFamily._dependencies,
          allTransitiveDependencies:
              PokemonDetailScreenNotifierFamily._allTransitiveDependencies,
          pokemonName: pokemonName,
        );

  PokemonDetailScreenNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pokemonName,
  }) : super.internal();

  final String pokemonName;

  @override
  FutureOr<Pokemon?> runNotifierBuild(
    covariant PokemonDetailScreenNotifier notifier,
  ) {
    return notifier.build(
      pokemonName,
    );
  }

  @override
  Override overrideWith(PokemonDetailScreenNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PokemonDetailScreenNotifierProvider._internal(
        () => create()..pokemonName = pokemonName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pokemonName: pokemonName,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PokemonDetailScreenNotifier, Pokemon?>
      createElement() {
    return _PokemonDetailScreenNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonDetailScreenNotifierProvider &&
        other.pokemonName == pokemonName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pokemonName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PokemonDetailScreenNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<Pokemon?> {
  /// The parameter `pokemonName` of this provider.
  String get pokemonName;
}

class _PokemonDetailScreenNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PokemonDetailScreenNotifier,
        Pokemon?> with PokemonDetailScreenNotifierRef {
  _PokemonDetailScreenNotifierProviderElement(super.provider);

  @override
  String get pokemonName =>
      (origin as PokemonDetailScreenNotifierProvider).pokemonName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
