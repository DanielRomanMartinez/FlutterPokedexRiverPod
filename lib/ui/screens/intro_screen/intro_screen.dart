import 'package:flutter/material.dart';
import 'package:flutter_pokedex/application/screens/intro_screen/intro_screen_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/ui/common/theme/shapes.dart';
import 'package:go_router/go_router.dart';

class IntroScreen extends ConsumerWidget {
  static const String routeName = 'intro';

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introState = ref.watch(introScreenNotifierProvider);

    ref.listen(introScreenNotifierProvider, (previous, next) {
      if (next != null && next != 'loading') {
        context.go("/$next");
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/intro/intro_image_player.png'),
            const SizedBox(height: Shapes.gutter2x),
            const Text(
              'Are you ready for the adventure?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: Shapes.gutter),
            const Text(
              'Start exploring the world of Pokémon today!',
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 70),
            InkWell(
              onTap: () {
                if (introState != 'loading') {
                  ref.read(introScreenNotifierProvider.notifier).finishIntro();
                }
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF173EA5),
                ),
                child: introState == 'loading'
                    ? const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
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
