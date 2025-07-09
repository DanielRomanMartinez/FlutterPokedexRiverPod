import 'package:flutter/material.dart';
import 'package:flutter_pokedex/application/screens/splash_screen/splash_screen_notifier.dart';
import 'package:flutter_pokedex/application/screens/user_information/user_information_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAndNavigate();
    });
  }

  void _initializeAndNavigate() async {
    ref.read(userInformationNotifierProvider);

    final startupRoute = await ref.read(startupRouteProvider.future);

    if (mounted) {
      context.go("/$startupRoute");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userInformationNotifierProvider);

    return Scaffold(
      body: ColoredBox(
        color: userAsyncValue.when(
          data: (user) => user.mostPokemonTypeCaptured?.pokemonColor.background ?? const Color(0xFF000029),
          loading: () => const Color(0xFF000029),
          error: (_, __) => const Color(0xFF000029),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/pokedex_logo.png'),
              SizedBox(height: 20),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
