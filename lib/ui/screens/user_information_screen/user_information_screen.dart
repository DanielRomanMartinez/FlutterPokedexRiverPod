import 'package:flutter/material.dart';
import 'package:flutter_pokedex/application/screens/user_information/user_information_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/domain/model/objects/user.dart';
import 'package:flutter_pokedex/ui/common/theme/shapes.dart';
import 'package:flutter_pokedex/ui/common/widgets/application_layout/application_layout.dart';
import 'package:flutter_pokedex/ui/common/widgets/pokemon_type_card/pokemon_type_card.dart';

class UserInformationScreen extends ConsumerWidget {
  static const String routeName = 'user-information';

  const UserInformationScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final userAsyncValue = ref.watch(userInformationNotifierProvider);

    return ApplicationLayout(
      canPop: false,
      title: 'User Information',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: userAsyncValue.when(
            data: (user) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User stats',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: Shapes.gutter2x),
                  Row(
                    children: [
                      const Text(
                        'Pokemons captured: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        user.numPokemonsCaptured.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  user.mostPokemonTypeCaptured == null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: Shapes.gutter),
                  user.mostPokemonTypeCaptured == null
                      ? const SizedBox.shrink()
                      : Row(
                          children: [
                            const Text(
                              'Most type pokemon captured: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 6),
                            PokemonTypeCard(user.mostPokemonTypeCaptured!),
                          ],
                        ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: User.defaultBackgroundColor,
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(userInformationNotifierProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
