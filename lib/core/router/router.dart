import 'package:flutter/material.dart';
import 'package:fluttertest/core/shared/screen/main_screen.dart';
import 'package:fluttertest/modules/splash/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  redirect: (context, state) {
    debugPrint('Attempting route: ${state.uri.path}');
    return null;
  },
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/splash',
      name: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
