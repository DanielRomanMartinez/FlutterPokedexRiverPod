import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/application/common/widgets/bottom_navigation/bottom_navigation_notifier.dart';
import 'package:flutter_pokedex/application/screens/captured_pokemons/captured_pokemons_screen_notifier.dart';
import 'package:flutter_pokedex/application/screens/user_information/user_information_notifier.dart';
import 'package:flutter_pokedex/domain/model/objects/pokemon.dart';
import 'package:flutter_pokedex/domain/model/objects/pokemon_type.dart';
import 'package:flutter_pokedex/domain/model/objects/user.dart';
import 'package:flutter_pokedex/extensions/string_extension.dart';
import 'package:flutter_pokedex/ui/screens/captured_pokemons_screen/captured_pokemons_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class TestCapturedPokemonsNotifier extends CapturedPokemonsScreenNotifier {
  final Future<List<Pokemon>> _state;
  TestCapturedPokemonsNotifier(this._state);

  @override
  Future<List<Pokemon>> build() => _state;
}

class TestUserInformationNotifier extends UserInformationNotifier {
  final Future<User> _state;
  TestUserInformationNotifier(this._state);

  @override
  Future<User> build() => _state;
}

class TestBottomNavigationNotifier extends BottomNavigationNotifier {
  final PageScreen _state;
  TestBottomNavigationNotifier(this._state);

  @override
  PageScreen build() => _state;
}

class _Constants {
  static const String channelPath = "plugins.flutter.io/path_provider";
  static const String methodNameForPath = "getApplicationSupportDirectory";
  static const String methodNameForTempPath = "getTemporaryDirectory";
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const pokemon = Pokemon(
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

  setUpAll(() async {
    const String mockPath = '/mock/path';

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel(_Constants.channelPath),
      (MethodCall methodCall) async {
        if (methodCall.method == _Constants.methodNameForPath) {
          return mockPath;
        }
        if (methodCall.method == _Constants.methodNameForTempPath) {
          return mockPath;
        }
        return null;
      },
    );
  });

  group('Captured Screen Test', () {
    testWidgets('Pump and test widget - Initial Loading', (WidgetTester tester) async {
      const user = User(
        numPokemonsCaptured: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        mostPokemonTypeCaptured: null,
      );

      final completer = Completer<List<Pokemon>>();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            capturedPokemonsScreenNotifierProvider.overrideWith(() => TestCapturedPokemonsNotifier(completer.future)),
            userInformationNotifierProvider.overrideWith(() => TestUserInformationNotifier(Future.value(user))),
            bottomNavigationNotifierProvider
                .overrideWith(() => TestBottomNavigationNotifier(PageScreen.capturedPokemons)),
          ],
          child: const MaterialApp(
            home: CapturedPokemonsScreen(),
          ),
        ),
      );

      await tester.pump();

      Finder textFinder = find.text('Loading...');
      expect(textFinder, findsOneWidget);

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../../goldens/captured_pokemons_screen/captured_pokemons_screen_1.png'),
      );

      completer.complete([]);
      await tester.pump();
    });

    testWidgets('Pump and test widget - Pokemons Loaded', (WidgetTester tester) async {
      const user = User(
        numPokemonsCaptured: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        mostPokemonTypeCaptured: null,
      );

      const pokemons = [pokemon];

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              capturedPokemonsScreenNotifierProvider
                  .overrideWith(() => TestCapturedPokemonsNotifier(Future.value(pokemons))),
              userInformationNotifierProvider.overrideWith(() => TestUserInformationNotifier(Future.value(user))),
              bottomNavigationNotifierProvider
                  .overrideWith(() => TestBottomNavigationNotifier(PageScreen.capturedPokemons)),
            ],
            child: const MaterialApp(
              home: CapturedPokemonsScreen(),
            ),
          ),
        );

        await tester.pump();
      });

      Finder textFinder = find.text(pokemon.name.capitalize());
      expect(textFinder, findsOneWidget);

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../../goldens/captured_pokemons_screen/captured_pokemons_screen_2.png'),
      );
    });

    testWidgets('Pump and test widget - No Pokemons', (WidgetTester tester) async {
      const user = User(
        numPokemonsCaptured: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        mostPokemonTypeCaptured: null,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            capturedPokemonsScreenNotifierProvider.overrideWith(() => TestCapturedPokemonsNotifier(Future.value([]))),
            userInformationNotifierProvider.overrideWith(() => TestUserInformationNotifier(Future.value(user))),
            bottomNavigationNotifierProvider
                .overrideWith(() => TestBottomNavigationNotifier(PageScreen.capturedPokemons)),
          ],
          child: const MaterialApp(
            home: CapturedPokemonsScreen(),
          ),
        ),
      );

      await tester.pump();

      Finder textFinder = find.text('You didn\'t capture any Pokémon :(');
      expect(textFinder, findsOneWidget);
    });
  });
}
