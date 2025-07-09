import 'package:flutter/material.dart';
import 'package:flutter_pokedex/application/screens/captured_pokemons/captured_pokemons_screen_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/domain/model/objects/user.dart';
import 'package:flutter_pokedex/ui/common/theme/colors_map.dart';
import 'package:flutter_pokedex/ui/common/theme/shapes.dart';
import 'package:flutter_pokedex/ui/common/widgets/application_layout/application_layout.dart';
import 'package:flutter_pokedex/ui/common/widgets/pokemon_card/pokemon_card.dart';
import 'package:flutter_pokedex/ui/common/widgets/search_pokemon_field/search_pokemon_field.dart';
import 'package:flutter_pokedex/ui/screens/pokemon_detail_screen/pokemon_detail_screen.dart';
import 'package:go_router/go_router.dart';

part 'widgets/no_pokemons.dart';

class CapturedPokemonsScreen extends ConsumerWidget {
  static const String routeName = 'captured-pokemons';

  const CapturedPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capturedPokemonsAsyncValue = ref.watch(capturedPokemonsScreenNotifierProvider);

    return ApplicationLayout(
      canPop: false,
      title: 'Captured Pokemons',
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: ColorsMap.neutral100,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: SearchPokemonField(
                onChanged: (String text) {
                  ref.read(capturedPokemonsScreenNotifierProvider.notifier).searchPokemon(text);
                },
                placeHolder: 'Search pokemon',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: capturedPokemonsAsyncValue.when(
                  data: (pokemons) {
                    if (pokemons.isEmpty) {
                      return const NoPokemons();
                    }

                    return ListView.builder(
                      itemCount: pokemons.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                context.push("/${PokemonDetailScreen.routeName}/${pokemons[index].name}");
                              },
                              child: PokemonCard(pokemons[index]),
                            ),
                            const SizedBox(height: Shapes.gutter),
                          ],
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Loading...'),
                        SizedBox(width: 5),
                        CircularProgressIndicator(
                          color: User.defaultBackgroundColor,
                        ),
                      ],
                    ),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: $error'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => ref.invalidate(capturedPokemonsScreenNotifierProvider),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
