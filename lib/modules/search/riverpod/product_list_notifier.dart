import 'package:fluttertest/modules/search/data/entities/model/product.dart';
import 'package:fluttertest/modules/search/data/services/search_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_list_notifier.g.dart';

@riverpod
class ProductListNotifier extends _$ProductListNotifier {
  @override
  Future<List<Product>> build() async {
    return await getProducts();
  }

  Future<List<Product>> getProducts({int? limit}) async {
    state = const AsyncValue.loading();
    final products = await SearchApiService().getProducts(limit: limit);
    state = AsyncValue.data(products);
    return products;
  }
}
