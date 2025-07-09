import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/application/screens/home_screen/home_screen_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/ui/common/theme/shapes.dart';
import 'package:flutter_pokedex/ui/common/widgets/application_layout/application_layout.dart';
import 'package:flutter_pokedex/ui/common/widgets/pokemon_card/pokemon_card.dart';
import 'package:flutter_pokedex/ui/screens/pokemon_detail_screen/pokemon_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

part 'widgets/mock_pokemon.dart';
part 'widgets/error_message.dart';
part 'widgets/home_screen_loading.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeScreenAsyncValue = ref.watch(homeScreenNotifierProvider);

    return ApplicationLayout(
      canPop: false,
      title: 'Pokedex',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: ConnectivityWidget(
            showOfflineBanner: false,
            builder: (context, isOnline) {
              return homeScreenAsyncValue.when(
                data: (information) {
                  return ListView.builder(
                    itemCount: information['content'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              context.push(
                                "/${PokemonDetailScreen.routeName}/${information['content'][index].name}",
                              );
                            },
                            child: PokemonCard(information['content'][index]),
                          ),
                          const SizedBox(height: Shapes.gutter),
                        ],
                      );
                    },
                  );
                },
                loading: () => const HomeScreenLoading(),
                error: (error, stackTrace) {
                  if (isOnline) {
                    return ErrorMessage(
                      text: 'Something went wrong',
                      onRetry: () => ref.read(homeScreenNotifierProvider.notifier).refresh(cached: false),
                    );
                  }
                  return ErrorMessage(
                    text: 'No connectivity',
                    onRetry: () => ref.read(homeScreenNotifierProvider.notifier).refresh(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}