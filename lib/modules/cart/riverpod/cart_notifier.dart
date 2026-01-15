import 'package:fluttertest/core/utils/injection_container/injection_container.dart';
import 'package:fluttertest/modules/cart/data/entities/cart_product.dart';
import 'package:fluttertest/modules/cart/data/services/cart_storage.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_notifier.g.dart';

class CartState {
  final List<CartProduct> cartProducts;
  final int totalItems;

  CartState({required this.cartProducts, required this.totalItems});
  CartState copyWith({List<CartProduct>? cartProducts, int? totalItems}) {
    return CartState(
      cartProducts: cartProducts ?? this.cartProducts,
      totalItems: totalItems ?? this.totalItems,
    );
  }
}

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Future<CartState> build() async {
    return intialize();
  }

  Future<CartState> intialize() async {
    state = const AsyncLoading();
    final cartStorage = getIt.get<CartStorage>();
    final cartProducts = await cartStorage.getCartWithProducts();
    final data = CartState(
      cartProducts: cartProducts,
      totalItems: cartProducts.length,
    );
    state = AsyncData(data);
    return data;
  }

  Future<int> getCartItemCountByProductId(int productId) async {
    final cartStorage = getIt.get<CartStorage>();
    final cartProducts = await cartStorage.getCartItem(productId);
    return cartProducts?.quantity ?? 0;
  }

  Future<void> incrementCartItem(Product product, int quantity) async {
    final cartStorage = getIt.get<CartStorage>();
    if (product.id == null) {
      throw StateError('Product ID is null');
    }
    await cartStorage.updateCartItem(product, quantity);
    await _refreshProductList();
  }

  Future<void> decreaseCartItem(Product product, int quantity) async {
    final cartStorage = getIt.get<CartStorage>();
    if (product.id == null) {
      throw StateError('Product ID is null');
    }
    if (quantity <= 0) {
      await cartStorage.removeFromCart(product.id!);
    } else {
      await cartStorage.updateCartItem(product, quantity);
    }
    await _refreshProductList();
  }

  Future<void> deleteCartItem(Product product) async {
    final cartStorage = getIt.get<CartStorage>();
    if (product.id == null) {
      throw StateError('Product ID is null');
    }
    await cartStorage.removeFromCart(product.id!);
    await _refreshProductList();
  }

  Future<void> _refreshProductList() async {
    final cartStorage = getIt.get<CartStorage>();
    final cartProducts = await cartStorage.getCartWithProducts();
    final data = CartState(
      cartProducts: cartProducts,
      totalItems: cartProducts.length,
    );
    state = AsyncData(data);
  }
}
