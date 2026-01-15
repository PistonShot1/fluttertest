import 'dart:convert';
import 'package:fluttertest/core/utils/storage/app_sqflite_storage.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductsStorage {
  final AppSqfliteStorage _storage;

  ProductsStorage._(this._storage);

  Database get database => _storage.database;

  static Future<ProductsStorage> create(AppSqfliteStorage storage) async {
    return ProductsStorage._(storage);
  }

  // ==================== CREATE ====================

  /// Insert a single product
  Future<int> insertProduct(Product product) async {
    final map = _productToMap(product);
    return await database.insert(
      ProductTablesDDL.productsTableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Insert multiple products
  Future<void> insertProducts(List<Product> products) async {
    final batch = database.batch();
    for (final product in products) {
      batch.insert(
        ProductTablesDDL.productsTableName,
        _productToMap(product),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // ==================== READ ====================

  /// Get all products
  Future<List<Product>> getAllProducts() async {
    final List<Map<String, dynamic>> maps = await database.query(
      ProductTablesDDL.productsTableName,
    );
    return maps.map((map) => _mapToProduct(map)).toList();
  }

  /// Get product by ID
  Future<Product?> getProductById(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      ProductTablesDDL.productsTableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return _mapToProduct(maps.first);
  }

  /// Get products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    final List<Map<String, dynamic>> maps = await database.query(
      ProductTablesDDL.productsTableName,
      where: 'category = ?',
      whereArgs: [category],
    );
    return maps.map((map) => _mapToProduct(map)).toList();
  }

  /// Search products by title (case-insensitive)
  Future<List<Product>> searchProductsByTitle(String query) async {
    final List<Map<String, dynamic>> maps = await database.query(
      ProductTablesDDL.productsTableName,
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
    );
    return maps.map((map) => _mapToProduct(map)).toList();
  }

  /// Get products with custom where clause
  Future<List<Product>> getProductsWhere({
    String? whereClause,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final List<Map<String, dynamic>> maps = await database.query(
      ProductTablesDDL.productsTableName,
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
    return maps.map((map) => _mapToProduct(map)).toList();
  }

  /// Get products count
  Future<int> getProductsCount() async {
    final result = await database.rawQuery(
      'SELECT COUNT(*) as count FROM ${ProductTablesDDL.productsTableName}',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ==================== UPDATE ====================

  /// Update a product
  Future<int> updateProduct(Product product) async {
    if (product.id == null) {
      throw ArgumentError('Product ID cannot be null for update');
    }

    final map = _productToMap(product);
    return await database.update(
      ProductTablesDDL.productsTableName,
      map,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  /// Update product price
  Future<int> updateProductPrice(int id, double price) async {
    return await database.update(
      ProductTablesDDL.productsTableName,
      {'price': price},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==================== DELETE ====================

  /// Delete a product by ID
  Future<int> deleteProduct(int id) async {
    return await database.delete(
      ProductTablesDDL.productsTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete products by category
  Future<int> deleteProductsByCategory(String category) async {
    return await database.delete(
      ProductTablesDDL.productsTableName,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  /// Delete all products
  Future<int> deleteAllProducts() async {
    return await database.delete(ProductTablesDDL.productsTableName);
  }

  // ==================== HELPER METHODS ====================

  /// Convert Product to Map for database insertion
  Map<String, dynamic> _productToMap(Product product) {
    final map = <String, dynamic>{
      'title': product.title,
      'price': product.price,
      'description': product.description,
      'category': product.category,
      'image': product.image,
      'rating': product.rating != null
          ? jsonEncode(product.rating!.toJson())
          : null,
    };

    if (product.id != null) {
      map['id'] = product.id;
    }

    return map;
  }

  Product _mapToProduct(Map<String, dynamic> map) {
    Rating? rating;
    if (map['rating'] != null && map['rating'] is String) {
      try {
        final ratingJson = jsonDecode(map['rating'] as String);
        rating = Rating.fromJson(ratingJson);
      } catch (e) {
        rating = null;
      }
    }

    return Product(
      id: map['id'] as int?,
      title: map['title'] as String?,
      price: map['price'] != null ? (map['price'] as num).toDouble() : null,
      description: map['description'] as String?,
      category: map['category'] as String?,
      image: map['image'] as String?,
      rating: rating,
    );
  }
}
