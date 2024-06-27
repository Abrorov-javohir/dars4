import 'package:dars64_statemanagement/models/orders.dart';
import 'package:flutter/material.dart';

class OrdersController extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(Map<String, dynamic> cartProducts) {
    _orders.add(
      Order(
        id: UniqueKey().toString(),
        products: cartProducts,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
