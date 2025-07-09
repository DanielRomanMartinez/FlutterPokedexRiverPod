import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/config/providers.dart';

part 'intro_screen_notifier.g.dart';

@riverpod
class IntroScreenNotifier extends _$IntroScreenNotifier {
  @override
  String? build() => null;

  Future<void> finishIntro() async {
    state = 'loading';

    final storageService = ref.read(getStorageServiceProvider);
    await storageService.write('firstTime', false);

    final routeService = ref.read(startUpRouteServiceProvider);
    final nextPage = await routeService.getInitialPage();
    state = nextPage;
  }
}