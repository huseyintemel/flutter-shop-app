import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
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
          leading : IconButton(
            icon: product.isFavorite ? const Icon(Icons.favorite,) : const Icon(Icons.favorite_border),
            color: Colors.red,
            onPressed:(){
              product.toogleFavoriteStatus();
            },
          ),
          trailing: const IconButton(icon: Icon(Icons.shopping_cart,), onPressed: null,color: Colors.red),
        ),
      ),
    );
  }
}