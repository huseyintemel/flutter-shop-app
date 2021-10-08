import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector( 
          onTap: (){
            Navigator.of(context).pushNamed('/product-detail',arguments: id);
          },
          child: Image.network(imageUrl,fit: BoxFit.cover,),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(title,textAlign: TextAlign.center,),
          leading : const IconButton(icon: Icon(Icons.favorite,color: Colors.red,),onPressed: null,),
          trailing: const IconButton(icon: Icon(Icons.shopping_cart,color: Colors.red,), onPressed: null,),
        ),
      ),
    );
  }
}