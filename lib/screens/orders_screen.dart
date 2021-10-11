import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders.dart' show Orders;
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
      return Scaffold(
        appBar: AppBar(title: const Text('Orders'),),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemBuilder: (ctx,index){
            return OrderItem(ordersData.orders[index]);
          },
          itemCount: ordersData.orders.length,
        ),
      );
  }
}