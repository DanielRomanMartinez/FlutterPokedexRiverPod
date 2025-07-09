import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/config/providers.dart';

part 'splash_screen_notifier.g.dart';

@riverpod
Future<String> startupRoute(Ref ref) async {
  final service = ref.read(startUpRouteServiceProvider);
  return await service.getInitialPage();
}