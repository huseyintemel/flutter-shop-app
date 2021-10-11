import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart.dart';

class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });

}


class Orders with ChangeNotifier{
  List<OrderItem> orders = [];

  List<OrderItem> get allItems{
    return [...orders];
  }

  void addOrder(List<CartItem> cartProducts,double total){
    orders.insert(0, OrderItem(id: DateTime.now().toString(),amount : total,dateTime:DateTime.now(),products: cartProducts,));
    notifyListeners();
  }

}