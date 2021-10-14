import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false
    
  });
  
  void toogleFavoriteStatus(String token){
    var params = {
        'auth': token,
    };
    isFavorite = !isFavorite;
    final url = Uri.https('flutter-app-3330c-default-rtdb.firebaseio.com','/products/$id.json',params);
    http.patch(url,body: json.encode({
      'isFavorite' : isFavorite,
    }));

    notifyListeners();  
  }

}