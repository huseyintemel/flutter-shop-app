import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Page'),),
      body: Column(
        children: [
          Card(
            elevation: 4,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Total',style: TextStyle(fontSize: 24),),
                  const Spacer(),
                  Chip(label: Text('\$${cart.totalAmount}'),backgroundColor: Theme.of(context).primaryColor,),
                  TextButton(child: const Text('ORDER NOW'),onPressed:(){},),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}