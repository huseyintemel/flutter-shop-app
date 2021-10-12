import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/edit_product_screen.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Products'),actions: [
        IconButton(icon:const Icon(Icons.add),onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
        },),        
      ],
    ),
    drawer: AppDrawer(),
    body: Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(itemBuilder: (ctx,index){
        return Column(children: [
          UserProductItem(productsData.items[index].title,productsData.items[index].imageUrl),
          const Divider(),
        ]
        );
      },
      itemCount: productsData.items.length,
      ) ,
    ),
    );
  }
}