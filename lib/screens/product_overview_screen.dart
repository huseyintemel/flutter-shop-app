import 'package:flutter/material.dart';

import 'package:flutter_shop_app/providers/cart.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/cart_screen.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
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
  var isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      isLoading = true;
    });
    Provider.of<Products>(context,listen: false).getProducts().then((_){
      setState(() {
        isLoading = false;
      });
    });
    print(isLoading);

    super.didChangeDependencies();
  }

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
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
        ),
      ],),
      drawer:AppDrawer(),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) : ProductGrid(showOnlyFavorites),
    ); 

  }
}