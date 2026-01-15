import 'dart:convert';

import 'package:fluttertest/core/utils/injection_container/injection_container.dart';
import 'package:fluttertest/core/utils/storage/app_sqflite_storage.dart';
import 'package:fluttertest/modules/cart/data/entities/cart_product.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';
import 'package:fluttertest/modules/search/data/services/products_storage.dart';
import 'package:sqflite/sqflite.dart';

class CartItem {
  final int productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  CartItem copyWith({
    int? productId,
    int? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CartStorage {
  final AppSqfliteStorage _storage;

  CartStorage._(this._storage);

  Database get database => _storage.database;

  static Future<CartStorage> create(AppSqfliteStorage storage) async {
    return CartStorage._(storage);
  }

  // ==================== CREATE====================
  /// Upsert cart item (Insert or Update if exists)
  /// If product exists in cart, it will update the quantity and updated_at
  Future<int> upsertCartItem(int productId, int quantity) async {
    final now = DateTime.now();

    // Check if item exists
    final existing = await getCartItem(productId);

    final map = {
      'product_id': productId,
      'quantity': quantity,
      'created_at':
          existing?.createdAt.millisecondsSinceEpoch ??
          now.millisecondsSinceEpoch,
      'updated_at': now.millisecondsSinceEpoch,
    };

    return await database.insert(
      CartTablesDDL.cartTableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Add item to cart (increases quantity if already exists)
  Future<void> updateCartItem(Product product, int quantity) async {
    final existing = await getCartItem(product.id!);

    if (existing != null) {
      if (product.id == null) {
        throw StateError('Product ID is null');
      }
      await upsertCartItem(product.id!, quantity);
    } else {
      // New item
      final productStorage = getIt.get<ProductsStorage>();
      final productData = await productStorage.insertProduct(product);
      await upsertCartItem(productData, quantity);
    }
  }

  /// Insert multiple cart items (batch upsert)
  Future<void> upsertCartItems(List<CartItem> items) async {
    final batch = database.batch();
    for (final item in items) {
      batch.insert(
        CartTablesDDL.cartTableName,
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // ==================== READ ====================

  /// Get all cart items
  Future<List<CartItem>> getAllCartItems() async {
    final List<Map<String, dynamic>> maps = await database.query(
      CartTablesDDL.cartTableName,
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => CartItem.fromMap(map)).toList();
  }

  /// Get cart item by product ID
  Future<CartItem?> getCartItem(int productId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      CartTablesDDL.cartTableName,
      where: 'product_id = ?',
      whereArgs: [productId],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return CartItem.fromMap(maps.first);
  }

  /// Get all cart items with product details (JOIN)
  Future<List<CartProduct>> getCartWithProducts() async {
    final query =
        '''
      SELECT 
        c.product_id,
        c.quantity,
        c.created_at,
        c.updated_at,
        p.id,
        p.title,
        p.price,
        p.description,
        p.category,
        p.image,
        p.rating
      FROM ${CartTablesDDL.cartTableName} c
      LEFT JOIN ${ProductTablesDDL.productsTableName} p ON c.product_id = p.id
      ORDER BY c.created_at DESC
    ''';

    final List<Map<String, dynamic>> maps = await database.rawQuery(query);

    return maps.map((map) {
      final cartItem = CartItem(
        productId: map['product_id'] as int,
        quantity: map['quantity'] as int,
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          map['created_at'] as int,
        ),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(
          map['updated_at'] as int,
        ),
      );

      Product? product;
      if (map['id'] != null) {
        // Use the helper from ProductsStorage to convert
        product = _mapToProduct(map);
      }

      return CartProduct(cartItem: cartItem, product: product);
    }).toList();
  }

  /// Get total items count in cart
  Future<int> getCartItemsCount() async {
    final result = await database.rawQuery(
      'SELECT COUNT(*) as count FROM ${CartTablesDDL.cartTableName}',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Get total quantity of all items in cart
  Future<int> getTotalQuantity() async {
    final result = await database.rawQuery(
      'SELECT SUM(quantity) as total FROM ${CartTablesDDL.cartTableName}',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Calculate total cart value (requires JOIN with products)
  Future<double> getCartTotalValue() async {
    final query =
        '''
      SELECT SUM(c.quantity * p.price) as total
      FROM ${CartTablesDDL.cartTableName} c
      INNER JOIN ${ProductTablesDDL.productsTableName} p ON c.product_id = p.id
    ''';

    final result = await database.rawQuery(query);
    final value = result.first['total'];

    if (value == null) return 0.0;
    return (value as num).toDouble();
  }

  // ==================== UPDATE ====================

  /// Update cart item quantity
  Future<int> updateCartItemQuantity(int productId, int quantity) async {
    if (quantity <= 0) {
      // If quantity is 0 or negative, remove the item
      return await removeFromCart(productId);
    }

    return await database.update(
      CartTablesDDL.cartTableName,
      {
        'quantity': quantity,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'product_id = ?',
      whereArgs: [productId],
    );
  }

  /// Increment cart item quantity
  Future<void> incrementQuantity(int productId, {int by = 1}) async {
    final item = await getCartItem(productId);
    if (item != null) {
      await updateCartItemQuantity(productId, item.quantity + by);
    }
  }

  /// Decrement cart item quantity
  Future<void> decrementQuantity(int productId, {int by = 1}) async {
    final item = await getCartItem(productId);
    if (item != null) {
      final newQuantity = item.quantity - by;
      if (newQuantity <= 0) {
        await removeFromCart(productId);
      } else {
        await updateCartItemQuantity(productId, newQuantity);
      }
    }
  }

  // ==================== DELETE ====================

  /// Remove item from cart by product ID
  Future<int> removeFromCart(int productId) async {
    return await database.delete(
      CartTablesDDL.cartTableName,
      where: 'product_id = ?',
      whereArgs: [productId],
    );
  }

  /// Clear entire cart
  Future<int> clearCart() async {
    return await database.delete(CartTablesDDL.cartTableName);
  }

  /// Remove items with 0 quantity (cleanup)
  Future<int> removeEmptyItems() async {
    return await database.delete(
      CartTablesDDL.cartTableName,
      where: 'quantity <= 0',
    );
  }

  // ==================== HELPER METHODS ====================

  /// Check if product is in cart
  Future<bool> isInCart(int productId) async {
    final item = await getCartItem(productId);
    return item != null;
  }

  /// Helper to convert map to Product (reused from ProductsStorage logic)
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
