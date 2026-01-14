import 'package:flutter/material.dart';
import 'package:fluttertest/core/router/route_constant.dart';
import 'package:fluttertest/core/shared/screen/main_screen.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';
import 'package:fluttertest/modules/search/presentation/product_detail_screen.dart';
import 'package:fluttertest/modules/splash/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  redirect: (context, state) {
    debugPrint('Attempting route: ${state.uri.path}');
    return null;
  },
  initialLocation: RouteConstant.main,
  routes: [
    GoRoute(
      path: RouteConstant.main,
      name: RouteConstant.main,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: RouteConstant.splash,
      name: RouteConstant.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteConstant.productDetail,
      name: RouteConstant.productDetail,
      builder: (context, state) {
        try {
          final product = state.extra as Product;
          return ProductDetailScreen(product: product);
        } catch (e) {
          throw UnimplementedError(
            'Product detail screen not implemented correctly. Error: $e',
          );
        }
      },
    ),
  ],
);
