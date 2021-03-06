import 'package:flutter/material.dart';
import 'product_provider.dart';

class ProductsProvider with ChangeNotifier {
  final List<ProductProvider> _items = [
    ProductProvider(
      id: 'p1',
      title: 'Red Shirt',
      desc: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductProvider(
      id: 'p2',
      title: 'Trousers',
      desc: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductProvider(
      id: 'p3',
      title: 'Yellow Scarf',
      desc: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductProvider(
      id: 'p4',
      title: 'A Pan',
      desc: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<ProductProvider> get items {
    return [..._items];
  }

  List<ProductProvider> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void add(ProductProvider product) {
    final newProduct = ProductProvider(
      id: DateTime.now().toString(),
      title: product.title,
      desc: product.desc,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void update(String id, ProductProvider product) {
    var productIndex = _items.indexWhere((item) => item.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = product;
      notifyListeners();
    }
  }

  void delete(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
