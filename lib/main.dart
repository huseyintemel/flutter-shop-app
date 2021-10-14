import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/auth.dart';
import 'package:flutter_shop_app/providers/cart.dart';
import 'package:flutter_shop_app/providers/orders.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/auth_screen.dart';
import 'package:flutter_shop_app/screens/cart_screen.dart';
import 'package:flutter_shop_app/screens/edit_product_screen.dart';
import 'package:flutter_shop_app/screens/orders_screen.dart';
import 'package:flutter_shop_app/screens/product_detail_page.dart';
import 'package:flutter_shop_app/screens/product_overview_screen.dart';
import 'package:flutter_shop_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,Products>(
          create: (_) => Products('',[]), 
          update: (ctx,auth,previousProduct) => Products(auth.token!,previousProduct!.items),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth,Orders>(
          create: (_) => Orders('',[]), 
          update: (ctx,auth,previousProduct) => Orders(auth.token!,previousProduct!.orders),
        ),
      ],
      child: Consumer<Auth>(builder: (ctx,auth,_) => MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
        routes: {
          ProductDetailPage.routeName : (context) => ProductDetailPage(),
          CartScreen.routeName : (context) => CartScreen(),
          OrdersScreen.routeName : (context) => OrdersScreen(),
          UserProductsScreen.routeName : (context) => UserProductsScreen(),
          EditProductScreen.routeName : (context) => EditProductScreen(),
          AuthScreen.routeName : (context) => AuthScreen(),
        },
      ),), 
    );
  }
} 