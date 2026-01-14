import 'dart:io';
import 'package:fluttertest/core/utils/network/http_handler.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';

class SearchApiService {
  final HttpHandler httpHandler = HttpHandler();

  Future<List<Product>> getProducts({int? limit}) async {
    Map<String, dynamic> query = {};
    if (limit != null) {
      query['limit'] = limit;
    }
    final response = await httpHandler.get('/products', queryParams: query);
    if (response.isSuccess && response.error == null) {
      return (response.data as List<dynamic>)
          .map((product) => Product.fromJson(product))
          .toList();
    } else {
      throw HttpException(
        'Failed to fetch products : ${response.error?.name} - ${response.message}',
      );
    }
  }
}
