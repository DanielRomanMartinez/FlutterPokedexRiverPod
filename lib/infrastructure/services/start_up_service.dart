import 'package:flutter_pokedex/domain/services/get_storage_service.dart';
import 'package:flutter_pokedex/domain/services/start_up_service.dart';

class FlutterStartUpService implements StartUpService {
  final GetStorageService getStorageService;

  FlutterStartUpService({
    required this.getStorageService,
  });

  @override
  Future<void> init() async {
    await getStorageService.init();
  }
}
