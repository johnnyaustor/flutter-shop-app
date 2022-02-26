import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart' show CartProvider;
import '../providers/orders_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 20)),
                const Spacer(),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.titleMedium!.color,
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                TextButton(
                  child: const Text('Order Now'),
                  onPressed: () {
                    context
                        .read<OrdersProvider>()
                        .add(cart.items.values.toList(), cart.totalAmount);
                    cart.clear();
                  },
                )
              ],
            ),
          ),
        ),
        const SizedBox(),
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (_, i) {
              final item = cart.items.values.toList()[i];
              return CartItem(
                productId: cart.items.keys.toList()[i],
                id: item.id,
                title: item.title,
                qty: item.qty,
                price: item.price,
              );
            },
          ),
        ),
      ]),
    );
  }
}
