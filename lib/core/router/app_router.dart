import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upsc_wars_new/features/home/presentation/pages/home_page.dart';
import 'package:upsc_wars_new/features/splash/presentation/pages/splash_page.dart';

part 'app_router.g.dart';

/// Named routes — always use [AppRoute.xxx.name] with [context.goNamed] so
/// that path changes never break call sites.
enum AppRoute {
  splash,
  home,
}

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
