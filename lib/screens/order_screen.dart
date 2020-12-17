import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders'),),
      drawer: AppDrawer(),
      body: Center(child: Text('You orders 😑'),),
    );
  }
}
