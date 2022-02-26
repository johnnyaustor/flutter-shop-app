import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int qty;
  final double price;

  const CartItem({
    required this.id,
    required this.title,
    required this.qty,
    required this.price,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qty;
    });
    return total;
  }

  void add(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (cart) => CartItem(
          id: cart.id,
          title: cart.title,
          qty: cart.qty + 1,
          price: cart.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          qty: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void remove(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
