import 'package:flutter/material.dart';
import 'package:fluttertest/core/router/route_constant.dart';
import 'package:fluttertest/core/shared/screen/main_screen.dart';
import 'package:fluttertest/modules/cart/presentation/cart_screen.dart';
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
          final data = state.extra as Map<String, dynamic>;
          final cartItemCount = data['cartItemCount'] as int;
          final productData = data['product'] as Map<String, dynamic>;
          final product = Product.fromJson(productData);
          return ProductDetailScreen(
            product: product,
            initialCartItemCount: cartItemCount,
          );
        } catch (e) {
          throw UnimplementedError(
            'Routing to product detail screen not implemented correctly. Error: $e',
          );
        }
      },
    ),
    GoRoute(
      path: RouteConstant.cart,
      name: RouteConstant.cart,
      builder: (context, state) => const CartScreen(),
    ),
  ],
);
