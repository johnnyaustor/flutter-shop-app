import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final String id;
  final double price;
  final int qty;
  final String title;

  const CartItem({
    Key? key,
    required this.productId,
    required this.id,
    required this.price,
    required this.qty,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content:
                  const Text('Do you want to remove the item from the cart?'),
              actions: [
                TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.pop(ctx, false);
                    }),
                TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.pop(ctx, true);
                    }),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        context.read<CartProvider>().remove(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * qty}'),
            trailing: Text('$qty x'),
          ),
        ),
      ),
    );
  }
}
