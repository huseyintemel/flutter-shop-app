import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/auth.dart';
import 'package:flutter_shop_app/providers/cart.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,listen: false); //widget not rebuilded every time when icon clicked
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context,listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector( 
          onTap: (){
            Navigator.of(context).pushNamed('/product-detail',arguments: product.id);
          },
          child: Image.network(product.imageUrl,fit: BoxFit.cover,),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(product.title,textAlign: TextAlign.center,),
          leading : Consumer<Product>(
            builder: (context,product,child){
              return IconButton(
              icon: product.isFavorite ? const Icon(Icons.favorite,) : const Icon(Icons.favorite_border),
              color: Colors.red,
              onPressed:(){
                product.toogleFavoriteStatus(authData.token!,authData.userId!);
              },
            );
            }
          ),
          trailing: IconButton(icon: const Icon(Icons.shopping_cart,), 
          onPressed:(){
            cart.addItem(product.id, product.price, product.title);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Added item to cart'),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(label: 'UNDO', onPressed: (){
                  cart.removeSingleItem(product.id);
                }),
              ),
            );
          },
          color: Colors.red),
        ),
      ),
    );
  }
}