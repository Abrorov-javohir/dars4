import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';
import 'orders_controller.dart';

class CartController extends ChangeNotifier {
  final Cart _cart = Cart(
    products: {},
    totalPrice: 0,
  );

  Cart get cart {
    return _cart;
  }

  void addToCart(Product product) {
    if (isProductInCart(product.id)) {
      _cart.products[product.id]['amount']++;
    } else {
      _cart.products[product.id] = {
        "product": product,
        "amount": 1,
      };
    }
    calculateTotalPrice();
    notifyListeners();
  }

  void removeFromCart(String productId) {
    if (_cart.products[productId]['amount'] == 1) {
      _cart.products.remove(productId);
    } else {
      _cart.products[productId]['amount']--;
    }
    calculateTotalPrice();
    notifyListeners();
  }

  void removeProduct(String productId) {
    _cart.products.remove(productId);
    calculateTotalPrice();
    notifyListeners();
  }
  

  void calculateTotalPrice() {
    double total = 0;
    _cart.products.forEach((key, value) {
      total += value['product'].price * value['amount'];
    });
    _cart.totalPrice = total;
  }

  bool isProductInCart(String productId) {
    return _cart.products.containsKey(productId);
  }

  int getProductAmount(String productId) {
    return _cart.products[productId]['amount'];
  }

  void purchaseProducts(OrdersController ordersController) {
    ordersController.addOrder(_cart.products);
    _cart.products.clear();
    _cart.totalPrice = 0;
    notifyListeners();
  }
}
