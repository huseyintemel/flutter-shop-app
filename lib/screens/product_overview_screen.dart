import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/product_grid.dart';

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
      ],),
      body: ProductGrid(showOnlyFavorites),
    ); 

  }
}