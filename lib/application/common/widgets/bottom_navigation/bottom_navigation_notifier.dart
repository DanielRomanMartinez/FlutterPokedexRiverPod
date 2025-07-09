import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_navigation_notifier.g.dart';

enum PageScreen {
  home(0),
  capturedPokemons(1),
  user(2);

  const PageScreen(this.value);
  final int value;
}

@riverpod
class BottomNavigationNotifier extends _$BottomNavigationNotifier {
  @override
  PageScreen build() => PageScreen.home;

  void setPage(PageScreen page) {
    state = page;
  }
}
