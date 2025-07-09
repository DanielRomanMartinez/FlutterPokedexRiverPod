import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/domain/model/objects/user.dart';
import 'package:flutter_pokedex/config/providers.dart';

part 'user_information_notifier.g.dart';

@riverpod
class UserInformationNotifier extends _$UserInformationNotifier {
  @override
  Future<User> build() async {
    final service = ref.read(userServiceProvider);
    return await service.getUserInformation();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}