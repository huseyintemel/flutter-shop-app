import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final String authToken;
  final String userId;

  Orders(this.authToken,this.userId,this.orders);

  List<OrderItem> get allItems{
    return [...orders];
  }

  Future<void> getOrders() async{
    var params = {
        'auth': authToken,
    };
    final url = Uri.https('flutter-app-3330c-default-rtdb.firebaseio.com','/orders/$userId.json',params);

    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
  
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime:  DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>).map(
            (item) => CartItem(id: item['id'], title: item['title'], quantity: item['quantity'], price: item['price'])
          ).toList(),
        ),
      );
    });
    orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts,double total) async{
    var params = {
        'auth': authToken,
    };
    final url = Uri.https('flutter-app-3330c-default-rtdb.firebaseio.com','/orders/$userId.json',params);
    final timestamp = DateTime.now();
    final response = await http.post(url,body: json.encode({
      'amount':total,
      'dateTime' : timestamp.toIso8601String(),
      'products' : cartProducts.map((cp) => {
        'id':cp.id,
        'title':cp.title,
        'quantity':cp.quantity,
        'price':cp.price,
      }).toList(),
    }));

    orders.insert(0, OrderItem(id: json.decode(response.body)['name'],amount : total,dateTime:timestamp,products: cartProducts,));
    notifyListeners();
  }

}