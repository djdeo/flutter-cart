import 'package:flutter/material.dart';
import 'package:flutter_cart/screens/auth_screen.dart';
import 'package:flutter_cart/widgets/battery_life.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import '../screens/user_products_screen.dart';
import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Consumer<Auth>(
            builder: (ctx, auth, _) => AppBar(
              title: Text(auth.userInfo['email']),
              automaticallyImplyLeading:false, // whici will never add a Back button
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Expanded(child: Container()),
          Divider(),
          BatterLife(),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pushNamed(AuthScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
