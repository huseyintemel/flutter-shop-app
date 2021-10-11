import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductItem(this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.edit),onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },),
            IconButton(icon: Icon(Icons.delete,color: Theme.of(context).errorColor,),onPressed: (){},),
          ],
        ),
      ),
    );
  }
}