import 'package:dars64_statemanagement/controllers/cart_controller.dart';
import 'package:dars64_statemanagement/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return ListTile(
      leading: Container(
        width: 60,
        color: product.color,
      ),
      title: Text(
        product.title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "\$${product.price}",
      ),
      trailing: Consumer<CartController>(
        builder: (ctx, cartController, child) {
          return cartController.isProductInCart(product.id)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        cartController.removeFromCart(product.id);
                      },
                      icon: const Icon(Icons.remove_circle),
                    ),
                    Text(
                      cartController.getProductAmount(product.id).toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cartController.addToCart(product);
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                )
              : IconButton(
                  onPressed: () {
                    cartController.addToCart(product);
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  ),
                );
        },
      ),
    );
  }
}
