import 'package:flutter/material.dart';

import 'package:flutter_shop_app/providers/cart.dart';
import 'package:flutter_shop_app/widgets/badge.dart';
import 'package:flutter_shop_app/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions{
  all,
  favorites
} 

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products'),
      actions: <Widget>[
        PopupMenuButton(icon: const Icon(Icons.more_vert),
        onSelected: (FilterOptions option){
          setState(() {
            if(option == FilterOptions.favorites){
              showOnlyFavorites = true;
            }
            else {
              showOnlyFavorites = false;
            }
          });
        },
        itemBuilder: (_) =>
        [
          const PopupMenuItem(child: Text('Favorites'),value: FilterOptions.favorites,),
          const PopupMenuItem(child: Text('All Products'),value: FilterOptions.all,),
        ],
        ),
        Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
                  child: ch as Widget,
                  value: cart.itemCount.toString(),
                ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                
              },
            ),
        ),
      ],),
      body: ProductGrid(showOnlyFavorites),
    ); 

  }
}