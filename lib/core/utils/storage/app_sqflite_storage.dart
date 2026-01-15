import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductTablesDDL {
  static const String productsTableName = 'products';

  static const String productsDDL =
      '''
      CREATE TABLE IF NOT EXISTS $productsTableName (
        id INTEGER PRIMARY KEY,
        title TEXT,
        price REAL,
        description TEXT,
        category TEXT,
        image TEXT,
        rating TEXT
      )
      ''';
}

class CartTablesDDL {
  static const String cartTableName = 'cart';

  static const String cartDDL =
      '''
      CREATE TABLE IF NOT EXISTS $cartTableName (
        product_id INTEGER PRIMARY KEY,
        quantity INTEGER NOT NULL DEFAULT 1,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (product_id) REFERENCES ${ProductTablesDDL.productsTableName}(id) ON DELETE CASCADE
      )
      ''';
}

class AppSqfliteStorage {
  final Database database;

  AppSqfliteStorage._(this.database);

  static AppSqfliteStorage? _instance;

  static Future<AppSqfliteStorage> create() async {
    if (_instance == null) {
      final database = await _initializeDb();
      _instance = AppSqfliteStorage._(database);
    }
    return _instance!;
  }

  static Future<Database> _initializeDb() async {
    final databasePath = (Platform.isAndroid)
        ? await getDatabasesPath()
        : (await getLibraryDirectory()).path;

    final path = join(databasePath, 'app.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );

    // Create all tables
    await _createProductsTable(database);
    await _createCartTable(database);

    debugPrint("Database created and all tables initialized");
    return database;
  }

  static Future<void> _createProductsTable(Database db) async {
    await db.execute(ProductTablesDDL.productsDDL);
    debugPrint("Created products table");
  }

  static Future<void> _createCartTable(Database db) async {
    await db.execute(CartTablesDDL.cartDDL);
    debugPrint("Created cart table");
  }
}
