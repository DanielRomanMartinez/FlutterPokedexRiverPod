import 'package:flutter/material.dart';
import 'package:flutter_pokedex/application/common/widgets/bottom_navigation/bottom_navigation_notifier.dart';
import 'package:flutter_pokedex/application/screens/user_information/user_information_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/domain/model/objects/user.dart';
import 'package:flutter_pokedex/ui/common/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';

class ApplicationLayout extends ConsumerWidget {
  static const String routeName = 'home';

  final Widget child;
  final bool canPop;
  final String title;

  const ApplicationLayout({
    super.key,
    required this.child,
    required this.canPop,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userInformationNotifierProvider);
    final currentPage = ref.watch(bottomNavigationNotifierProvider);

    return userAsyncValue.when(
      data: (user) {
        return Scaffold(
          appBar: AppBar(
            leading: canPop
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: user.foregroundColor,
                    ),
                    onPressed: () => context.pop(),
                  )
                : const SizedBox.shrink(),
            title: Text(
              title,
              style: TextStyle(color: user.foregroundColor),
            ),
            backgroundColor: user.backgroundColor,
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            pageScreen: currentPage,
            color: user.backgroundColor,
          ),
          body: child,
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(
          leading: canPop
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: User.defaultForegroundColor,
                  ),
                  onPressed: () => context.pop(),
                )
              : const SizedBox.shrink(),
          title: Text(
            title,
            style: const TextStyle(color: User.defaultForegroundColor),
          ),
          backgroundColor: User.defaultBackgroundColor,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          pageScreen: currentPage,
          color: User.defaultBackgroundColor,
        ),
        body: child,
      ),
      error: (error, stackTrace) => Scaffold(
        appBar: AppBar(
          leading: canPop
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: User.defaultForegroundColor,
                  ),
                  onPressed: () => context.pop(),
                )
              : const SizedBox.shrink(),
          title: Text(
            title,
            style: const TextStyle(color: User.defaultForegroundColor),
          ),
          backgroundColor: User.defaultBackgroundColor,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          pageScreen: currentPage,
          color: User.defaultBackgroundColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error loading user information: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(userInformationNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
