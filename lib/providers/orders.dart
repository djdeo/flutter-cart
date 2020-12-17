import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amout;
  final List<CartItemEl> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amout,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItemEl> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amout: total,
          dateTime: DateTime.now(),
          products: cartProducts,
        ));

    notifyListeners();
  }
}
