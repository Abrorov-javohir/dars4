import 'package:dars64_statemanagement/controllers/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersController = Provider.of<OrdersController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buyurtmalar"),
      ),
      body: ordersController.orders.isEmpty
          ? const Center(
              child: Text("Buyurtmalar yo'q."),
            )
          : ListView.builder(
              itemCount: ordersController.orders.length,
              itemBuilder: (ctx, index) {
                final order = ordersController.orders[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      "Buyurtma: \$${order.products.values.fold(0.0, (previousValue, element) => previousValue + element['product'].price * element['amount'],)}",
                    ),
                    subtitle: Text(order.date.toString()),
                  ),
                );
              },
            ),
    );
  }
}
