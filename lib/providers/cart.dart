import 'package:flutter/foundation.dart';

class CartItemEl {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItemEl({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItemEl> _items = {};

  Map<String, CartItemEl> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, el) {
      total += el.price * el.quantity;
    });

    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItemEl) => CartItemEl(
                id: existingCartItemEl.id,
                title: existingCartItemEl.title,
                price: existingCartItemEl.price,
                quantity: existingCartItemEl.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItemEl(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
