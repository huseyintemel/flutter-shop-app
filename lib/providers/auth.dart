import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier{
  String? token;
  String? email;
  String? password;

  Future<void> authanticate(String email,String password,String segmentName) async{
      var params = {
      'key': 'AIzaSyA7xtoC4jmgxTaGmdpowPxKyE7lVXlI5XM',
    };
    final url = Uri.https('identitytoolkit.googleapis.com', '/v1/accounts:$segmentName', params);
      final response = await http.post(url,body: json.encode({
        'email' : email,
        'password' : password,
        'returnSecureToken' : true,
      }));
      print(json.decode(response.body));
  }

  Future<void> signUp(String email,String password) async{
    authanticate(email, password, 'signUp');  
  }

  Future<void> login(String email,String password) async{
    authanticate(email, password, 'signInWithPassword');
  }
}