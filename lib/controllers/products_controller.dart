import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductsController extends ChangeNotifier {
  final List<Product> _list = [
    Product(
      id: UniqueKey().toString(),
      title: "Samsung Galaxy S24 Ultra",
      price: 1000,
      color: Colors.blue,
    ),
    Product(
      id: UniqueKey().toString(),
      title: "Redmi Note 14 Pro Plus 5G",
      price: 900,
      color: Colors.teal,
    ),
    Product(
      id: UniqueKey().toString(),
      title: "Iphon 15 Pro Max",
      price: 1200,
      color: Colors.grey,
    ),
    Product(
      id: UniqueKey().toString(),
      title: "Macbook Pro",
      price: 1225.5,
      color: Colors.red,
    ),
  ];

  List<Product> get list {
    return [..._list];
  }

  void addProduct(Product product) {
    _list.add(product);
    notifyListeners();
  }

  void updateProduct(String id, String title, double price, Color color) {
    final productIndex = _list.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      _list[productIndex] = Product(id: id, title: title, price: price, color: color);
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _list.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
