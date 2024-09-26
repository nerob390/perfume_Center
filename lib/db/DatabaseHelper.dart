
import 'package:flutter_standard/model/Product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/CartProduct.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Cart.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        // Create Cart table
        // await db.execute(
        //     "CREATE TABLE Cart(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, price TEXT NOT NULL, discountPercentage TEXT NOT NULL, rating TEXT NOT NULL, stock TEXT NOT NULL, brand TEXT NOT NULL, category TEXT NOT NULL, thumbnail TEXT NOT NULL);"
        // );

        // Create CartProducts table
        await db.execute(
            "CREATE TABLE CartProducts(id TEXT PRIMARY KEY, title TEXT NOT NULL, price TEXT NOT NULL,thumbnail TEXT NOT NULL, quantity INTEGER NOT NULL);"
        );
      },
      version: _version,
    );
  }

  static Future<int> addToCat(ProductItem product) async {
    final db = await _getDB();
    // Use toCartJson() to insert only id, title, price, and quantity
    return await db.insert(
      "CartProducts",
      product.toCartJson(),  // Insert only the selected fields
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<bool> checkIfProductExists(String productId) async {
    final db = await _getDB();

    // Query the database for the product ID
    final List<Map<String, dynamic>> result = await db.query(
      "CartProducts",
      where: "id = ?",
      whereArgs: [productId],
    );

    // If result is not empty, the product exists
    return result.isNotEmpty;
  }

  static Future<int> countCartProducts() async {
    final db = await _getDB();

    // Query to count the number of rows in the CartProducts table
    final result = await db.rawQuery('SELECT COUNT(*) FROM CartProducts');

    // The result is returned as a list of maps, so we access the count value at index 0
    int count = Sqflite.firstIntValue(result) ?? 0;

    return count;
  }

  static Future<List<CartProduct>> getCartProducts() async {
    final db = await _getDB();
    final maps = await db.query("CartProducts");

    return List.generate(maps.length, (i) {
      return CartProduct.fromJson(maps[i]);
    });
  }

  static Future<int> updateCartProduct(CartProduct product) async {
    final db = await _getDB();
    return await db.update(
      "CartProducts",
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  static Future<int> removeCartProduct(String id) async {
    final db = await _getDB();
    return await db.delete(
      "CartProducts",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> clearCart() async {
    final db = await _getDB();
    await db.delete("CartProducts");
  }

  static Future<double> calculateTotalPrice() async {
    final db = await _getDB();

    // Query to get all products and their prices & quantities
    final List<Map<String, dynamic>> result = await db.query("CartProducts");

    double totalPrice = 0;

    // Calculate total price by iterating over the cart items
    for (var product in result) {
      double price = double.parse(product['price']);
      int quantity = product['quantity'];
      totalPrice += price * quantity;
    }

    return totalPrice;
  }


}