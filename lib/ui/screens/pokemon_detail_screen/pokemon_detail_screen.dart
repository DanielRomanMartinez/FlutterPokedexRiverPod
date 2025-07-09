import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/application/screens/pokemon_detail_screen/pokemon_detail_screen_notifier.dart';
import 'package:flutter_pokedex/extensions/string_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/domain/model/objects/user.dart';
import 'package:flutter_pokedex/ui/common/theme/shapes.dart';
import 'package:flutter_pokedex/ui/common/widgets/application_layout/application_layout.dart';
import 'package:flutter_pokedex/ui/common/widgets/pokemon_type_card/pokemon_type_card.dart';

class PokemonDetailScreen extends ConsumerWidget {
  static const String routeName = 'pokemon-detail';

  final String name;

  const PokemonDetailScreen({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsyncValue = ref.watch(pokemonDetailScreenNotifierProvider(name));

    return pokemonAsyncValue.when(
      data: (pokemon) {
        if (pokemon == null) {
          return const Scaffold(
            body: Center(
              child: Text('Pokemon not found'),
            ),
          );
        }

        return ApplicationLayout(
          canPop: true,
          title: pokemon.name.capitalize(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      pokemon.types.first.pokemonColor.background,
                      pokemon.types.first.pokemonColor.cardBackground,
                    ],
                    stops: const [0.15, 0.85],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(250),
                    bottomLeft: Radius.circular(250),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/pokemon_type_logos/big_white/${pokemon.types.first.name.toLowerCase()}.png',
                        scale: 0.5,
                      ),
                    ),
                    Center(
                      child: Transform.scale(
                        scale: 2.2,
                        child: CachedNetworkImage(
                          imageUrl: pokemon.image,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (pokemon.isCaptured) {
                          ref.read(pokemonDetailScreenNotifierProvider(name).notifier).unleashPokemon(pokemon);
                        } else {
                          ref.read(pokemonDetailScreenNotifierProvider(name).notifier).capturePokemon(pokemon);
                        }
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: pokemon.isCaptured
                              ? Image.asset('assets/images/captured_pokemons_active.png', scale: 0.75)
                              : Image.asset('assets/images/captured_pokemons_black.png', scale: 0.75),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Shapes.gutter2x),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pokemon.name.capitalize(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Nº ${pokemon.id.toString().padLeft(3, '0')}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: Shapes.gutter2x),
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: pokemon.types.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              PokemonTypeCard(pokemon.types[index]),
                              const SizedBox(width: 4),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: Shapes.gutter),
                    Text(
                      pokemon.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: Shapes.gutter2x),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/weight_icon.png'),
                                  const SizedBox(width: 5),
                                  const Text('Peso'),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black.withValues(alpha: 0.10),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    pokemon.weight.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: Shapes.gutter2x),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/height_icon.png'),
                                  const SizedBox(width: 5),
                                  const Text('Altura'),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black.withValues(alpha: 0.10),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    pokemon.height.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: User.defaultBackgroundColor,
          ),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(pokemonDetailScreenNotifierProvider(name)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
