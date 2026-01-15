import 'package:fluttertest/modules/cart/data/services/cart_storage.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';

class CartProduct {
  final CartItem cartItem;
  final Product? product;

  CartProduct({required this.cartItem, this.product});
}
