import 'package:fluttertest/core/utils/storage/app_sqflite_storage.dart';
import 'package:fluttertest/modules/cart/data/services/cart_storage.dart';
import 'package:fluttertest/modules/search/data/services/products_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<http.Client>(http.Client());

  await registerAppSqfliteStorage();
}

Future<void> registerAppSqfliteStorage() async {
  getIt.registerSingletonAsync<AppSqfliteStorage>(
    () async => await AppSqfliteStorage.create(),
  );
  await getIt.isReady<AppSqfliteStorage>();

  final storage = await ProductsStorage.create(getIt<AppSqfliteStorage>());
  getIt.registerSingleton<ProductsStorage>(storage);

  final cartStorage = await CartStorage.create(getIt<AppSqfliteStorage>());
  getIt.registerSingleton<CartStorage>(cartStorage);
}
