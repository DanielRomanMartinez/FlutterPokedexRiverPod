import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/application.dart';
import 'package:flutter_pokedex/config/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final container = ProviderContainer();
  final startUpService = container.read(startUpServiceProvider);
  await startUpService.init();
  container.dispose();

  runApp(
    const ProviderScope(
      child: Pokedex(),
    ),
  );
}